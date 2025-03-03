import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'app_colors.dart';

class AppLoadings {
  // Three rotating dots
  static Widget loadingThreeDot({required Color color, required double size}) {
    return LoadingAnimationWidget.threeRotatingDots(color: color, size: size);
  }

  static OverlayEntry? _overlayEntry;

  static void showOverlayLoading({String? message}) {
    print('showOverlayLoading called');
    // Check if an existing overlay is already displayed
    if (_overlayEntry != null) {
      print('Overlay already exists, removing the previous one.');
      hideOverlayLoading(); // Remove the existing overlay
    }

    BuildContext? context = Get.overlayContext;

    if (context == null) {
      print('Error: Overlay context is null.');
      return;
    }

    _overlayEntry = OverlayEntry(
      builder:
          (context) => Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: Container(
                  color: AppColors.primary,
                ), // Semi-transparent overlay
              ),

              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitSpinningLines(
                      color: AppColors.onPrimary,
                      size: 60.r,
                    ),
                  ],
                ),
              ),
            ],
          ),
    );

    OverlayState? overlayState = Overlay.of(context);

    overlayState.insert(_overlayEntry!);
  }

  static void hideOverlayLoading() {
    try {
      if (_overlayEntry != null) {
        _overlayEntry!.remove();
        _overlayEntry = null; // Clear the reference
        print('Overlay successfully removed.');
      } else {
        print('No overlay to remove.');
      }
    } catch (e) {
      print('Error while removing overlay: $e');
    }
  }

  // InkDrop Loading Widget
  static Widget loadingWidgetInkDrop({
    required double size,
    required Color color,
  }) {
    return LoadingAnimationWidget.inkDrop(color: color, size: size);
  }
}
