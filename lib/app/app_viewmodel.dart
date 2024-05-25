import 'package:bingo/app/locator.dart';
import 'package:bingo/core/styles/theme.dart';
import 'package:bingo/data/sources/local/storage.dart';
import 'package:bingo/domain/services/app/app_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AppModel extends ReactiveViewModel {
  final AppService _themeService = getIt();
  final LocalStorage _localStorage = getIt<LocalStorageImpl>();

  ReactiveValue<ThemeMode> get themeMode => _themeService.themeMode;

  final ReactiveValue _darkTheme = ReactiveValue(DefaultAppThemes.darkTheme);
  final ReactiveValue _lightTheme = ReactiveValue(DefaultAppThemes.lightTheme);

  ThemeData get darkTheme => _darkTheme.value;
  ThemeData get  lightTheme => _lightTheme.value;

  @override
  List<ListenableServiceMixin> get listenableServices => [_themeService];

  void onReady() {
    _themeService.setThemeMode(_localStorage.getThemeMode());
  }
}
