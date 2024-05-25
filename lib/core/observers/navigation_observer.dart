import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class NavigationObserver extends AutoRouteObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    debugPrint('New route pushed: ${route.settings.name}');
  }
}
