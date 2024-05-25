import 'package:bingo/app/locator.dart';
import 'package:bingo/domain/services/navigation_service/navigation_service.dart';
import 'package:bingo/domain/services/templates/templates_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddTemplateViewModel extends ReactiveViewModel {
  final _templateService = getIt<TemplateService>();

  TextEditingController editingController = TextEditingController();

  Future<void> createTemplate() async {
    setBusy(true);
    try {
      await _templateService.createTemplate(editingController.text);
    } catch (e) {
      NavigationService.showErrorToast(e.toString());
    }
    setBusy(false);
    NavigationService.back();
  }
}
