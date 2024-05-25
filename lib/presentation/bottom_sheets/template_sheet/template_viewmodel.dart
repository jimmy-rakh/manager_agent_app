import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/data/models/template/response.dart';
import 'package:bingo/domain/services/templates/templates_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TemplateSheetViewModel extends BaseViewModel {
  final TemplateService _templateService = getIt();
  late List<TemplateResponse> templates;

  void onReady(int productId) {
    getData(productId);
  }

  Future<void> getData(int productId) async {
    setBusy(true);
    try {
      final res = await _templateService.fetchTemplatesByProduct(productId);
      templates = res;
    } catch (e) {}
    setBusy(false);
  }

  void onSelect(String id) {
    Navigator.pop(router.navigatorKey.currentContext!, id);
  }
}
