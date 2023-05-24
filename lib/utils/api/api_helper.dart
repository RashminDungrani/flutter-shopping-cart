// Author - Rashmin Dungrani

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:shopping_cart/injection_container.dart';

import '../../app/data/api_paths.dart';

import '../log_helper.dart';

import 'api_exceptions.dart';
import 'network_info.dart';

enum HTTPMethod {
  post,
  get,
  delete,
  patch,
  put,
  multipartPost,
}

extension HttpMethodExtension on HTTPMethod {
  String get contentType {
    switch (this) {
      case HTTPMethod.post:
        return 'application/x-www-form-urlencoded';
      case HTTPMethod.get:
        return 'application/json';
      case HTTPMethod.delete:
        return 'application/json';
      case HTTPMethod.patch:
        return 'application/x-www-form-urlencoded';
      case HTTPMethod.multipartPost:
        return 'application/x-www-form-urlencoded';
      default:
        return 'application/json';
    }
  }
}

class APIHelper {
  final String serviceName;
  final String endPoint;
  final String baseUrl;

  final bool checkInternet;
  final bool printRequest;
  final bool printResponse;
  final bool printHeaders;

  final Map<String, String>? additionalHeader;
  final Map<String, String>? useOnlyThisHeader;
  final int timeoutDurationInSeconds;

  APIHelper({
    required this.endPoint,
    this.baseUrl = ApiPaths.apiBaseUrl,
    this.serviceName = ' ',
    this.checkInternet = true,
    this.printRequest = true,
    this.printResponse = false,
    this.printHeaders = false,
    this.additionalHeader,
    this.useOnlyThisHeader,
    this.timeoutDurationInSeconds = 60,
  });

  Uri get apiUri => Uri.parse(baseUrl + endPoint);

  Map<String, String> getHeaders(HTTPMethod method) {
    final Map<String, String> headers = {};
    headers['Content-Type'] = method.contentType;

    if (useOnlyThisHeader != null) {
      headers.addAll(useOnlyThisHeader!);
      return headers;
    }

    headers['User-Agent'] = Platform.isIOS ? 'iOS' : 'Android';

    if (additionalHeader != null) {
      headers.addAll(additionalHeader!);
    }

    if (printHeaders) {
      Log.error('*** HEADER in $endPoint API ***');
      Log.error(headers.toPrettyString());
    }

    return headers;
  }

  Future<Either<APIExceptionBase, Map<String, dynamic>>> getAPI() async {
    return _executeRequest(HTTPMethod.get);
  }

  Future<Either<APIExceptionBase, Map<String, dynamic>>> postAPI({
    required Map<String, dynamic> body,
    bool isFormData = false,
  }) async {
    return _executeRequest(HTTPMethod.post, body: body, isFormData: isFormData);
  }

  Future<Either<APIExceptionBase, Map<String, dynamic>>> putAPI({
    required Map<String, dynamic> body,
  }) async {
    return _executeRequest(
      HTTPMethod.put,
      body: body,
    );
  }

  Future<Either<APIExceptionBase, Map<String, dynamic>>> patchAPI({
    required Map<String, dynamic> body,
  }) async {
    return _executeRequest(HTTPMethod.patch, body: body);
  }

  Future<Either<APIExceptionBase, Map<String, dynamic>>> deleteAPI() async {
    return _executeRequest(HTTPMethod.delete);
  }

  Future<Either<APIExceptionBase, Map<String, dynamic>>> _executeRequest(
    HTTPMethod method, {
    Map<String, dynamic>? body,
    bool isFormData = false,
  }) async {
    if (checkInternet) {
      if (!await sl.get<NetworkInfo>().checkIsConnected) {
        return Left(NoInternetException());
      }
    }

    final headers = getHeaders(method);

    late final Response response;

    try {
      switch (method) {
        case HTTPMethod.get:
          response = await Client()
              .get(
                apiUri,
                headers: headers,
              )
              .timeout(Duration(seconds: timeoutDurationInSeconds));
        case HTTPMethod.post:
          response = await Client()
              .post(
                apiUri,
                headers: headers,
                body: isFormData ? body : jsonEncode(body),
              )
              .timeout(Duration(seconds: timeoutDurationInSeconds));
        case HTTPMethod.put:
          response = await Client()
              .put(
                apiUri,
                headers: headers,
                body: body,
              )
              .timeout(Duration(seconds: timeoutDurationInSeconds));
        case HTTPMethod.patch:
          response = await Client()
              .patch(
                apiUri,
                headers: headers,
                body: body,
              )
              .timeout(Duration(seconds: timeoutDurationInSeconds));
        case HTTPMethod.delete:
          response = await Client()
              .delete(
                apiUri,
                headers: headers,
              )
              .timeout(Duration(seconds: timeoutDurationInSeconds));
        case HTTPMethod.multipartPost:
          throw UnsupportedError(
              'Multipart Post is not supported in _executeRequest');
        default:
          throw ArgumentError('Invalid HttpMethod');
      }

      _printAPIResponse(response);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right(jsonDecode(response.body));
      } else {
        return Left(UnexpectedStatusCodeException(response));
      }
    } on TimeoutException {
      Log.error('timeout exception thrown');
      final networkInfo = sl.get<NetworkInfo>();
      networkInfo.isConnected = false;
      networkInfo.requestStatus = EnumRequestStatus.requestTimeout;
      return Left(TimeoutException(timeoutDurationInSeconds));
    } catch (e) {
      Log.error(e);
      return Left(UnhandledException(e));
    }
  }

  Future<Either<APIExceptionBase, Map<String, dynamic>>> postMultipartAPI({
    required Map<String, String> body,
    required Map<String, dynamic> files,
  }) async {
    try {
      // Prepare the request body
      final request = http.MultipartRequest('POST', apiUri);

      // Add body parameters
      request.fields.addAll(body);

      // Add files
      for (final entry in files.entries) {
        final file = await http.MultipartFile.fromPath(entry.key, entry.value);
        request.files.add(file);
      }

      // Send the request
      final streamedResponse = await request.send();

      // Parse the response
      final responseBody = await streamedResponse.stream.bytesToString();
      final response = Response(
        responseBody,
        streamedResponse.statusCode,
        headers: streamedResponse.headers,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right(jsonDecode(response.body));
      } else {
        return Left(UnexpectedStatusCodeException(response));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      //  Left({'message': 'An error occurred'});
      return Left(UnhandledException(e));
    }
  }

  // API response info...
  void _printAPIResponse(Response response) {
    late final String responseBody;
    if (printResponse) {
      try {
        responseBody = Map<String, dynamic>.from(jsonDecode(response.body))
            .toPrettyString();
      } catch (e) {
        Log.error("-- RESPONSE BODY IS NOT PROPER in $endPoint API --");
        responseBody = response.body;
      }
    }
    if (printResponse &&
        response.statusCode >= 200 &&
        response.statusCode < 300) {
      Log.success("""
╔════════════════════════════════════════════════════════════════════════════╗
║      API RESPONSE                                                          ║
╠════════════════════════════════════════════════════════════════════════════╣
║ API        :- $endPoint
║ StatusCode :- ${response.statusCode}
║ Response   :- 

$responseBody

╚════════════════════════════════════════════════════════════════════════════╝
""");
    } else if (printResponse) {
      Log.error("""
╔════════════════════════════════════════════════════════════════════════════╗
║      API RESPONSE                                                          ║
╠════════════════════════════════════════════════════════════════════════════╣
║ API        :- $endPoint
║ StatusCode :- ${response.statusCode}
║ Response   :- 

$responseBody

╚════════════════════════════════════════════════════════════════════════════╝
""");
    }
  }
}

extension APIMapBody on Map<String, dynamic> {
  String toPrettyString() {
    var encoder = const JsonEncoder.withIndent("     ");
    return encoder.convert(this);
  }
}
