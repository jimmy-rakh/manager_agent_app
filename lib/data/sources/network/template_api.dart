import 'dart:convert';

import 'package:bingo/app/locator.dart';
import 'package:bingo/core/network/constants.dart';
import 'package:bingo/core/network/globuskans_api_service.dart';
import 'package:bingo/data/models/orders/requests/create.dart';
import 'package:bingo/data/models/orders/response/order_details_dto.dart';
import 'package:bingo/data/models/products/request/add_cart_request.dart';
import 'package:bingo/data/models/template/delete_template.dart';
import 'package:bingo/data/models/template/response.dart';

abstract class TemplateApi {
  Future<List<TemplateResponse>> fetchTemplates();
  Future<List<TemplateResponse>> fetchTemplatesByProduct(int productId);
  Future<void> createTemplate(String name);
  Future<void> deleteTemplate(DeleteTEmplateRequest request);
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

class TemplateApiImpl implements TemplateApi {
  final BingoApi _api = getIt();

  @override
  Future<void> createTemplate(String name) async {
    final data = jsonEncode({"name": name});
    try {
      return _api.post(
        NetworkConstants.templates,
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteTemplate(DeleteTEmplateRequest request) async {
    try {
      return _api.delete(
        NetworkConstants.templates,
        data: request.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TemplateResponse> fetchTemplate(String templateId) async {
    try {
      final res = await _api.get('${NetworkConstants.templates}$templateId/');
      return TemplateResponse.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TemplateResponse>> fetchTemplates() async {
    try {
      final res = await _api.get(NetworkConstants.templates);
      return List.from(res).map((e) => TemplateResponse.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateTemplate(String productId, int quantity) async {
    try {
      final data = jsonEncode({"quantity": quantity});

      await _api.put(
        '${NetworkConstants.templateProduct}$productId/',
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TemplateResponse>> fetchTemplatesByProduct(int productId) async {
    try {
      final res =
          await _api.get('${NetworkConstants.templates}?product_id=$productId');
      return List.from(res).map((e) => TemplateResponse.fromJson(e)).toList();
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
      await _api.post('${NetworkConstants.templates}$templateId/',
          data: request.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteTemplateProduct(
      String templateId, String productId) async {
    try {
      final data = jsonEncode({"id": productId});
      await _api.delete(
        '${NetworkConstants.templates}$templateId/',
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addBulkProducts(String templateId, List<int> products) async {
    try {
      final data = jsonEncode({"products": products});
      await _api.post(
        NetworkConstants.bulkTemplates.replaceAll('{id}', templateId),
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteBulkProducts(String templateId, List<int> products) async {
    try {
      final data = jsonEncode({"ids": products});
      await _api.delete(
        NetworkConstants.bulkTemplates.replaceAll('{id}', templateId),
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<OrderDetailsDto> createOrder(
      String templateId, CreateOrderDto request) async {
    try {
      final res = await _api.post(
        NetworkConstants.createTemplateOrder.replaceAll('{id}', templateId),
        data: request.toJson(),
      );

      return OrderDetailsDto.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }
}
