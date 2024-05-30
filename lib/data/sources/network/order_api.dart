import 'dart:convert';
import 'package:bingo/app/locator.dart';
import 'package:bingo/core/network/constants.dart';
import 'package:bingo/core/network/globuskans_api_service.dart';
import 'package:bingo/data/models/orders/requests/add_comment.dart';
import 'package:bingo/data/models/orders/requests/confirm_oreder.dart';
import 'package:bingo/data/models/orders/requests/create.dart';
import 'package:bingo/data/models/orders/requests/pay_submit.dart';
import 'package:bingo/data/models/orders/response/delivery_cost_dto.dart';
import 'package:bingo/data/models/orders/response/order_details_dto.dart';
import '../../models/orders/response/orders.dart';

abstract class OrderApi {
  Future<OrderDetailsDto> createOrder(int? inn,CreateOrderDto request);
  Future<OrdersDto> fetchOrders(int? inn, {String? url, String? status});
  Future<OrderDetailsDto> fetchOrderById(int? inn,String orderId);
}

class OrderApiImpl extends OrderApi {
  final BingoApi _bingoApi = getIt();

  @override
  Future<OrderDetailsDto> createOrder(int? inn,CreateOrderDto request) async {
    try {
      final res =
          await _bingoApi.post("${NetworkConstants.orders}$inn/", data: request.toJson());
      return OrderDetailsDto.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<OrdersDto> fetchOrders(int? inn,{String? url, String? status}) async {
    try {
      final res = await _bingoApi.get(url ?? ("${NetworkConstants.orders}$inn"));
      return OrdersDto.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<OrderDetailsDto> fetchOrderById(int? inn,String orderId) async {
    try {
      final res = await _bingoApi.get("${NetworkConstants.order}$inn/$orderId");
      return OrderDetailsDto.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> submitOrderById(String orderId) async {
    try {
      await _bingoApi.post('${NetworkConstants.orders}$orderId/submit-rework/',);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> cancelOrderById(String orderId) async {
    try {
      await _bingoApi.delete('${NetworkConstants.orders}$orderId/');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future addReview(AddReviewRequest request) async {
    try {
      await _bingoApi.post(
          NetworkConstants.addReview.replaceAll(
            '{id}',
            request.productId.toString(),
          ),
          data: request.toJson());
      // return OrderDetailsDto.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DeliveryCostDto> fetchDeliveryCost(int addressId) async {
    try {
      final res = await _bingoApi.post(NetworkConstants.deliveryCost,
          data: json.encode({"address_id": addressId}));
      return DeliveryCostDto.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> paySubmit(PaySubmitModel data) async {
    try {
      await _bingoApi.post(
          '${NetworkConstants.orders}${data.orderId}/pay-submit/',
          data: data.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> confirmOrder(ConfirmOrderRequest request) async {
    try {
      await _bingoApi.post(
          '${NetworkConstants.orders}${request.orderId}/delivery-check/',
          data: request.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
