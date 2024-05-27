import 'package:bingo/app/locator.dart';
import 'package:bingo/data/models/orders/requests/add_comment.dart';
import 'package:bingo/data/models/orders/requests/confirm_oreder.dart';
import 'package:bingo/data/models/orders/requests/create.dart';
import 'package:bingo/data/models/orders/requests/pay_submit.dart';
import 'package:bingo/data/models/orders/response/delivery_cost_dto.dart';
import 'package:bingo/data/models/orders/response/order_details_dto.dart';
import 'package:bingo/data/models/orders/response/order_list_dto.dart';
import 'package:bingo/data/sources/local/storage.dart';
import 'package:bingo/data/sources/network/order_api.dart';

abstract class OrderRepository {
  Future<OrderDetailsDto> createOrder(CreateOrderDto request);
  Future<UserOrdersDto> fetchOrders(int? inn,{String? url, String? status});
  Future<OrderDetailsDto> fetchOrderById(String orderId);
  Future<void> submitOrderById(String orderId);
  Future<void> cancelOrderById(String orderId);
  Future addReview(AddReviewRequest request);
  Future fetchDeliveryCost(int addressId);
  Future<void> paySubmit(PaySubmitModel data);
  Future<void> confirmOrder(ConfirmOrderRequest request);
  void addWaitpayOrder(List<int> orderIds);
  List<int> getWaitpayOrders();
}

class OrderRepositoryImpl implements OrderRepository {
  final OrderApi _api = getIt<OrderApiImpl>();
  final LocalStorage _localStorage = getIt<LocalStorageImpl>();

  @override
  Future<OrderDetailsDto> createOrder(request) async {
    try {
      return await _api.createOrder(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserOrdersDto> fetchOrders(int? inn,{String? url, String? status}) async {
    try {
      return await _api.fetchOrders( inn,url: url, status: status);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<OrderDetailsDto> fetchOrderById(String orderId) async {
    try {
      return await _api.fetchOrderById(orderId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> submitOrderById(String orderId) async {
    try {
       await _api.submitOrderById(orderId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> cancelOrderById(String orderId) async {
    try {
       await _api.cancelOrderById(orderId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future addReview(AddReviewRequest request) async {
    try {
      return await _api.addReview(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DeliveryCostDto> fetchDeliveryCost(int addressId) async {
    try {
      return await _api.fetchDeliveryCost(addressId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> paySubmit(PaySubmitModel data) async {
    try {
      await _api.paySubmit(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> confirmOrder(ConfirmOrderRequest request) async {
    try {
      await _api.confirmOrder(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void addWaitpayOrder(List<int> orderIds) {
    _localStorage.addWaitpayOrder(orderIds);
  }

  @override
  List<int> getWaitpayOrders() {
    return _localStorage.getWaitpayOrders();
  }
}
