import 'package:bingo/app/locator.dart';
import 'package:bingo/data/models/orders/requests/create.dart';
import 'package:bingo/data/models/orders/response/order_details_dto.dart';
import 'package:bingo/data/models/products/request/add_cart_request.dart';
import 'package:bingo/data/models/template/delete_template.dart';
import 'package:bingo/data/models/template/response.dart';
import 'package:bingo/data/sources/network/template_api.dart';

abstract class TemplateRepository {
  Future<List<TemplateResponse>> fetchTemplates();

  Future<List<TemplateResponse>> fetchTemplatesByProduct(int productId);

  Future<void> createTemplate(String name);

  Future<void> deleteTemplate(String id);

  Future<TemplateResponse> fetchTemplate(String templateId);

  Future<void> updateTemplate(String productId, int quantity);

  Future<void> deleteTemplateProduct(String templateId, String productId);

  Future<void> addProductToTemplate({
    required AddCartRequest request,
    required String templateId,
  });

  Future<void> addBulkProducts(String templateId, List<int> products);

  Future<void> deleteBulkProducts(String templateId, List<int> products);

  Future<OrderDetailsDto> createOrder(
      String templateId, CreateOrderDto request);
}

class TemplateRepositoryImpl implements TemplateRepository {
  final TemplateApi _api = getIt<TemplateApiImpl>();

  @override
  Future<void> createTemplate(String name) async {
    try {
      await _api.createTemplate(name);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteTemplate(String id) async {
    final request = DeleteTEmplateRequest(id: id);
    try {
      await _api.deleteTemplate(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TemplateResponse> fetchTemplate(String templateId) async {
    try {
      return await _api.fetchTemplate(templateId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TemplateResponse>> fetchTemplates() async {
    try {
      return await _api.fetchTemplates();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateTemplate(String productId, int quantity) async {
    try {
      await _api.updateTemplate(productId, quantity);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TemplateResponse>> fetchTemplatesByProduct(int productId) async {
    try {
      return await _api.fetchTemplatesByProduct(productId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addProductToTemplate({
    required AddCartRequest request,
    required String templateId,
  }) async {
    try {
      await _api.addProductToTemplate(request: request, templateId: templateId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteTemplateProduct(
      String templateId, String productId) async {
    try {
      await _api.deleteTemplateProduct(templateId, productId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addBulkProducts(String templateId, List<int> products) async {
    try {
      _api.addBulkProducts(templateId, products);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteBulkProducts(String templateId, List<int> products) async {
    try {
      _api.deleteBulkProducts(templateId, products);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<OrderDetailsDto> createOrder(
      String templateId, CreateOrderDto request) async {
    try {
      return await _api.createOrder(templateId, request);
    } catch (e) {
      rethrow;
    }
  }
}
