import 'dart:async';

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

import '../log_helper.dart';

enum ToastType {
  success,
  failure,
  info,
}

extension CheckToastType on ToastType {
  bool get isSuccess => this == ToastType.success;
  bool get isFailure => this == ToastType.failure;
  bool get isInfo => this == ToastType.info;
}

Future<void> showTopFlashMessage(
  BuildContext context,
  ToastType toastType,
  String message,
) async {
  // if (!mounted) return;
  try {
    if (context.mounted == false) {
      return;
    }

    await showFlash(
        context: context,
        duration: const Duration(seconds: 3),
        builder: (_, controller) {
          return Flash(
            controller: controller,
            position: FlashPosition.top,
            // behavior: FlashBehavior.fixed,
            // backgroundColor: toastType.isFailure
            //     ? Colors.red.shade300
            //     : toastType.isSuccess
            //         ? Colors.green.shade300
            //         : Colors.white,
            child: FlashBar(
              controller: controller,
              icon: Icon(
                toastType.isFailure
                    ? Icons.close_sharp
                    : toastType.isSuccess
                        ? Icons.check_circle
                        : Icons.priority_high_rounded,
                size: 30,
                color: Colors.black,
              ),
              content: Text(message,
                  style: const TextStyle(fontSize: 16, color: Colors.black)),
            ),
          );
        });
  } catch (e) {
    Log.error('showTopFlashMessage catch error : ($e)');
  }
}

// TODO: make this global accessor
// RxBool isTimerRunning = false.obs;

// Future<bool> willPopCallBack(BuildContext context) async {
//   if (!isTimerRunning.value) {
//     isTimerRunning.value = true;
//     Timer.periodic(const Duration(seconds: 2), (time) {
//       isTimerRunning.value = false;
//       time.cancel();
//     });
//     await showTopFlashMessage(context ,ToastType.info, 'Press back again to exit');
//     return false;
//   }
//   await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//   return true;
// }
