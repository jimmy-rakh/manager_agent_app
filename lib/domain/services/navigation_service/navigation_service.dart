import 'package:bingo/app/router.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NavigationService {
  static bool isActiveDialog = false;

  static void back() {
    Navigator.pop(router.navigatorKey.currentContext!);
  }

  static void showSnackBar({required SnackBar snackBar}) {
    ScaffoldMessenger.of(router.navigatorKey.currentContext!)
        .showSnackBar(snackBar);
  }

  static void hideSnackBar() {
    ScaffoldMessenger.of(router.navigatorKey.currentContext!)
        .hideCurrentSnackBar();
  }

  static Future<dynamic>? showBottomSheet(
      {required Widget sheet,
      Color? barierColor,
      bool isDismissible = true,
      bool enableDrag = true}) async {
    return await showModalBottomSheet(
        context: router.navigatorKey.currentContext!,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: barierColor,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        builder: (context) {
          return sheet;
        });
  }

  static Future<dynamic>? showCustomDialog(
      {required Widget dialog,
      double? padding,
      Color barrierColor = Colors.black45}) {
    isActiveDialog = true;

    return showDialog(
        useSafeArea: false,
        context: router.navigatorKey.currentContext!,
        barrierDismissible: false,
        barrierColor: barrierColor,
        builder: (context) {
          return Dialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              child: dialog);
        });
  }

  static void showErrorToast(String text) {
    if (text ==
        'NoSuchMethodError: The method \'[]\' was called on null.\nReceiver: null\nTried calling: []("result")') {
      return;
    }
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  static void showToast(String text) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }
}
