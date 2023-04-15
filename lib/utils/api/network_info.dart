import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

import '../log_helper.dart';

enum EnumRequestStatus {
  allGood,
  noInternet,
  requestTimeout,
  somethingWentWrong,
}

abstract class NetworkInfo {
  bool isConnected = false;

  EnumRequestStatus requestStatus = EnumRequestStatus.allGood;
  Future<bool> get checkIsConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(
    this.connectivity, {
    this.isConnected = false,
    this.requestStatus = EnumRequestStatus.allGood,
  });
  final Connectivity connectivity;

  @override
  Future<bool> get checkIsConnected async {
    isConnected = false;
    try {
      isConnected =
          (await connectivity.checkConnectivity()) != ConnectivityResult.none;
      return isConnected;
    } on PlatformException catch (e) {
      Log.error('Couldn\'t check connectivity status e :: $e');
      return false;
    }
  }

  @override
  bool isConnected;

  @override
  EnumRequestStatus requestStatus;
}
