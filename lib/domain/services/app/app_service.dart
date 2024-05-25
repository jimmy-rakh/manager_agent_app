import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/core/utils/is_dark.dart';
import 'package:bingo/data/sources/local/storage.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AppService with ListenableServiceMixin {
  final LocalStorage _localStorage = getIt<LocalStorageImpl>();
  final ReactiveValue<bool> _isDarkTheme = ReactiveValue(
      isDarkModeEnabled(router.navigatorKey.currentContext));
  final ReactiveValue<ThemeMode> _themeMode = ReactiveValue(ThemeMode.system);

  ReactiveValue<bool> get isDarkTheme => _isDarkTheme;
  ReactiveValue<ThemeMode> get themeMode => _themeMode;

  AppService() {
    listenToReactiveValues([_isDarkTheme, _themeMode]);
  }

  void setThemeData(bool isDark) {
    _isDarkTheme.value = isDark;
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode.value = mode;
    _localStorage.setThemeMode(mode);
  }
}
