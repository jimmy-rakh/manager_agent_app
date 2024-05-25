import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/data/sources/local/storage.dart';
import 'package:bingo/domain/services/app/app_service.dart';
import 'package:bingo/domain/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SettingsScreenViewModel extends BaseViewModel {
  final AuthService _authService = getIt();
  final AppService _themeService = getIt();
  final LocalStorage _localStorage = getIt<LocalStorageImpl>();

  ThemeMode get themeMode => _localStorage.getThemeMode();

  void selectThemeMode(ThemeMode mode) async {
    print(mode);
    _themeService.setThemeMode(mode);
    notifyListeners();
  }

  void setLocale(String locale) async {
    _authService.setLanguage(locale);
    router.replace(const SplashRoute());
  }
}
