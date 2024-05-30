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

import '../../data/models/orders/response/orders.dart';

abstract class OrderRepository {
  Future<OrderDetailsDto> createOrder(int? inn,CreateOrderDto request);
  Future<OrdersDto> fetchOrders(int? inn,{String? url, String? status});
  Future<OrderDetailsDto> fetchOrderById(int? inn,String orderId);
}

class OrderRepositoryImpl implements OrderRepository {
  final OrderApi _api = getIt<OrderApiImpl>();
  final LocalStorage _localStorage = getIt<LocalStorageImpl>();

  @override
  Future<OrderDetailsDto> createOrder(int? inn,request) async {
    try {
      return await _api.createOrder(inn,request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<OrdersDto> fetchOrders(int? inn,{String? url, String? status}) async {
    try {
      return await _api.fetchOrders( inn,url: url, status: status);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<OrderDetailsDto> fetchOrderById(int? inn,String orderId) async {
    try {
      return await _api.fetchOrderById(inn,orderId);
    } catch (e) {
      rethrow;
    }
  }


}
