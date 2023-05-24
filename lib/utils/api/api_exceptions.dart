import 'package:http/http.dart';

class APIExceptionBase {}

class TimeoutException extends APIExceptionBase {
  final int timeoutDurationInSeconds;

  TimeoutException(this.timeoutDurationInSeconds);

  @override
  String toString() {
    return 'TimeoutException: Request timed out after $timeoutDurationInSeconds seconds';
  }
}

class NoInternetException extends APIExceptionBase {
  NoInternetException();

  @override
  String toString() {
    return 'NoInternetException';
  }
}

class UnexpectedStatusCodeException extends APIExceptionBase {
  final Response response;
  final int statusCode;

  UnexpectedStatusCodeException(this.response)
      : statusCode = response.statusCode;

  @override
  String toString() {
    return 'UnexpectedStatusCodeException: Received unexpected status code $statusCode';
  }
}

class NotFoundHttpException extends UnexpectedStatusCodeException {
  NotFoundHttpException(Response response) : super(response);

  @override
  String toString() {
    return 'NotFoundHttpException: The requested resource was not found. Status code: $statusCode';
  }
}

class UnauthorizedHttpException extends UnexpectedStatusCodeException {
  UnauthorizedHttpException(Response response) : super(response);

  @override
  String toString() {
    return 'UnauthorizedHttpException: The request requires user authentication. Status code: $statusCode';
  }
}

class UnhandledException extends APIExceptionBase {
  final Object exception;

  UnhandledException(this.exception);
}

/// API Error messages
abstract class APIErrorMsg {
  static const String socketException = 'Please try again later';

  // No Internet...
  static const String noInternet = "No Internet";
  static const String noInternetMsg = "Please check your internet connection";

  // Un-authorized user...
  static const String unAuthorizedTitle = "UnAuthorized";
  static const String unAuthorizedMsg =
      "The session is expired due to security reasons, please login again to continue.";

  // Default error msg...
  static const String defaultErrorTitle = "Error";
  static const String somethingWentWrong =
      "Something went wrong, please try again later...";

  // Under Maintenance...
  static const String underMaintenanceTitle = "Under Maintenance";
  static const String underMaintenanceMsg =
      "Sorry, we're down for scheduled maintenance right now, please try after some time.";

  // Invalid API response format...
  static const String invalidFormat = "Invalid format";

  // Socket Exception...
  static const String httpErrorMsg = "The server is currently unavailable.";

  // Request timeout...
  static const String requestTimeOutTitle = "Request Timeout";
  static const String requestTimeOutMessage =
      "Looks like the server is taking to long to respond, this can be caused by either poor connectivity or an error with our servers. Please try again in a while";
}
