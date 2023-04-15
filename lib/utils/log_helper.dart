import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

// Reset:   \x1B[0m
// Black:   \x1B[30m
// White:   \x1B[37m
// Red:     \x1B[31m
// Green:   \x1B[32m
// Yellow:  \x1B[33m
// Blue:    \x1B[34m
// Cyan:    \x1B[36m

abstract class Log {
  static Future<void> copyToClipboard(String message,
      {bool printMessage = false}) async {
    if (kReleaseMode) return;
    if (printMessage) {
      Log.info(message);
    }
    await Clipboard.setData(ClipboardData(text: message));

    Log.info("Copied to Clipboard");
  }

// Blue text
  static void info(dynamic msg) {
    if (kReleaseMode) return;
    developer.log('\x1B[34m${msg.toString()}\x1B[0m');
  }

// Green text
  static void success(dynamic msg) {
    if (kReleaseMode) return;
    developer.log('\x1B[32m${msg.toString()}\x1B[0m');
  }

// Yellow text
  static void warning(dynamic msg) {
    if (kReleaseMode) return;
    developer.log('\x1B[33m${msg.toString()}\x1B[0m');
  }

// Red text
  static void error(dynamic msg, {bool copyToClipboard = false}) {
    if (kReleaseMode) return;
    String msgString = msg.toString();
    developer.log('\x1B[31m$msgString\x1B[0m');
  }
}
