import 'package:bingo/app/locator.dart';
import 'package:bingo/domain/services/auth_service/auth_service.dart';
import 'package:bingo/domain/services/navigation_service/navigation_service.dart';
import 'package:bingo/domain/services/search_service/search_service.dart';
import 'package:bingo/presentation/bottom_sheets/select_lang_sheet/select_lang_sheet.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends ReactiveViewModel {
  final AuthService _authService = getIt();
  final SearchService _searchService = getIt();

  @override
  List<ListenableServiceMixin> get listenableServices => [_authService];

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool invisiblePassword = true;
  bool remember = false;

  void onReady() {
    initialCategories();
  }

  void onChooseLang() {
    NavigationService.showBottomSheet(
        sheet: const SelectLangSheet(), enableDrag: false);
  }

  void togglePasswordVisibility() {
    invisiblePassword = !invisiblePassword;
    rebuildUi();
  }

  void rememberToggle(bool? value) {
    remember = value ?? !remember;
    rebuildUi();
  }

  void onLogin() async {
    setBusy(true);
    try {
      await _authService.logIn(
          usernameController.text, passwordController.text);
    } catch (e) {
      print(e);
    }
    setBusy(false);
  }

  void initialCategories() {
    _searchService.fetchAllCategories();
  }
}
