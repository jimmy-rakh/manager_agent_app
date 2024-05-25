import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/domain/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SelectLangViewModel extends BaseViewModel {
  final AuthService _authService = getIt();

  void setLocale(String locale) async {
    _authService.setLanguage(locale);
    Navigator.pop(router.navigatorKey.currentContext!);
  }
}
