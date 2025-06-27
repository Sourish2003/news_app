import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../config/Theme/themes.dart';
import '../config/constants/app_constants.dart';

class ReusableSnackBar {
  static showSnackBar(BuildContext context, message) {
    Fluttertoast.cancel();
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: toastBackgroundColor,
      textColor: toastTextColor,
      fontSize: toastFontSize,
    );
  }

  static showErrSnackBar(BuildContext context, message) {
    Fluttertoast.cancel();
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: customErrorColor,
      textColor: toastTextColor,
      fontSize: toastFontSize,
    );
  }
}
