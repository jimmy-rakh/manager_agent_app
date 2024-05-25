
import 'package:bingo/app/locator.dart';import 'package:bingo/data/models/products/request/add_cart_request.dart';
import 'package:bingo/data/models/template/response.dart';
import 'package:bingo/domain/repositories/template_repository.dart';
import 'package:stacked/stacked.dart';

class TemplateService with ListenableServiceMixin {
  TemplateRepository get _repository => getIt<TemplateRepositoryImpl>();

  TemplateService() {
    listenToReactiveValues([_templates]);
  }

  final ReactiveList<TemplateResponse> _templates = ReactiveList();
  final ReactiveValue<bool> _isBusy = ReactiveValue(false);

  List<TemplateResponse> get templates => _templates;
  bool get isBusy => _isBusy.value;

  Future<void> fetchTemplates() async {
    try {
      _isBusy.value = true;
      final res = await _repository.fetchTemplates();
      _templates.clear();
      _templates.addAll(res);
    } catch (e) {
      rethrow;
    }
    _isBusy.value = false;
  }

  Future<TemplateResponse> fetchTemplate(String templateId) async {
    try {
      final res = await _repository.fetchTemplate(templateId);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TemplateResponse>> fetchTemplatesByProduct(int productId) async {
    try {
      final res = await _repository.fetchTemplatesByProduct(productId);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addProductToTemplate(
      {required int productId,
      required String templateId,
      required int quantity}) async {
    try {
      final request = AddCartRequest(productId: productId, quantity: quantity);
      await _repository.addProductToTemplate(
          request: request, templateId: templateId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTemplateProduct(
      String templateId, String productId) async {
    try {
      await _repository.deleteTemplateProduct(templateId, productId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createTemplate(String name) async {
    try {
      await _repository.createTemplate(name);
      fetchTemplates();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addBulkTemplate(String templateId, List<int> products) async {
    try {
      _repository.addBulkProducts(templateId, products);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteBulkTemplate(String templateId, List<int> products) async {
    try {
      _repository.deleteBulkProducts(templateId, products);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changeProductQuantity(String productId, int quantity) async {
    try {
      await _repository.updateTemplate(productId, quantity);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTemplate(String id) async {
    try {
      await _repository.deleteTemplate(id);
    } catch (e) {
      rethrow;
    }
  }
}
