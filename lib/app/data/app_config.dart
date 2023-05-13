// ignore: unused_import
import 'package:flutter/foundation.dart' show kDebugMode;
// import 'package:package_info_plus/package_info_plus.dart';

mixin AppConfig {
  static const String appName = "Shopping Cart";

  // static late final PackageInfo packageInfo;

  // kDebugMode;
  // static bool get isDebugMode => kDebugMode;
  static bool get setNoValidation => kDebugMode;

  // static const String twilioCountryCode = "1";

  // static bool isInProduction = false;

  static const isLandscapeOrientationSupported = false;
}
