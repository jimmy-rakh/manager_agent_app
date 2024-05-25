import 'package:bingo/app/router.dart';
import 'package:flutter/cupertino.dart';

class ScreenSize {
  static double width =
      MediaQuery.of(router.navigatorKey.currentContext!).size.width;

  static double height =
      MediaQuery.of(router.navigatorKey.currentContext!).size.height;

  static double pixelRatio =
      MediaQuery.of(router.navigatorKey.currentContext!)
          .devicePixelRatio;
}
