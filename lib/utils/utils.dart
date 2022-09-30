import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: const Color.fromARGB(255, 126, 244, 157),
        fontSize: 18);
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        borderRadius: BorderRadius.circular(10),
        message: message,
        flushbarPosition: FlushbarPosition.TOP,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 10,
        backgroundColor: const Color.fromARGB(255, 232, 36, 36),
        // title: "Error",
        duration: const Duration(seconds: 4),
      )..show(context),
    );
  }

  static snackBar(String message, Color color, BuildContext context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(backgroundColor: color, content: Text(message)));
  }
}
