// Author - Rashmin Dungrani

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'packages/loaders/staggered_dots_wave.dart';

class AppLoader extends StatelessWidget {
  final bool isOverlay;
  final double size;
  final Color loaderColor;

  const AppLoader({
    super.key,
    this.isOverlay = false,
    this.size = 30,
    this.loaderColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    // print(color);

    return Center(
        child: isOverlay
            ? Container(
                width: 125,
                height: 125,
                padding: const EdgeInsets.all(35),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                // * from loading_animation_widget package
                child:
                    // AppConfig.isDebugMode
                    //     ? getLoader(loaderColor)
                    //     :
                    const StaggeredDotsWave(color: Colors.white, size: 50)
                // Beat(size: 50, color: loaderColor),
                )
            :
            // AppConfig.isDebugMode
            //     ? getLoader(loaderColor)
            //     :
            StaggeredDotsWave(color: loaderColor, size: size)
        // Beat(color: loaderColor, size: size),
        );
  }

  Widget getLoader(Color loaderColor) {
    if (kDebugMode) {
      return Icon(Icons.refresh, color: loaderColor);
    }

    if (Platform.isIOS) {
      return const CupertinoActivityIndicator();
    } else {
      return const CircularProgressIndicator(
        strokeWidth: 3,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      );
    }
  }
}

class LoadingOverlay {
  LoadingOverlay._create(this._context);

  factory LoadingOverlay.of(BuildContext context) =>
      LoadingOverlay._create(context);
  BuildContext _context;

  void show({Color backColor = Colors.grey, bool showLoader = true}) {
    showDialog(
      context: _context,
      barrierDismissible: false,
      barrierColor: backColor,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          return Future.value(false);
        },
        child: showLoader ? const AppLoader(isOverlay: true) : const SizedBox(),
      ),
    );
  }

  void showTransparent() {
    showDialog(
      context: _context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          return Future.value(false);
        },
        child: const SizedBox(),
      ),
    );
  }

  void hide() {
    // Navigator.of(_context).pop();
    Navigator.of(_context, rootNavigator: true).pop('dialog');
  }

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(hide);
  }
}
