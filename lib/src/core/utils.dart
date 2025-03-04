import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'custom_elements/app_colors.dart';

class Utils {
  static showToastBottom({required String message, Color? color}) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: color ?? AppColors.secondary,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static showToastCenter({required String message, Color? color}) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: color ?? AppColors.secondary,
      gravity: ToastGravity.CENTER,
    );
  }

  static showToastTop({required String message, Color? color}) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: color ?? AppColors.secondary,
      gravity: ToastGravity.TOP,
    );
  }

  static String formatTime(DateTime time) {
    return '';
  }

  static String formatDate(DateTime date) {
    return '';
  }
}
