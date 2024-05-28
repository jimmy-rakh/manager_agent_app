import 'dart:convert';

import 'package:bingo/app/locator.dart';
import 'package:bingo/data/models/address/address_response.dart';
import 'package:bingo/data/models/card/response/get_card_response.dart';
import 'package:bingo/data/models/orders/requests/add_comment.dart';
import 'package:bingo/data/models/orders/requests/confirm_oreder.dart';
import 'package:bingo/data/models/orders/requests/create.dart';
import 'package:bingo/data/models/orders/requests/pay_submit.dart';
import 'package:bingo/data/models/orders/response/delivery_cost_dto.dart';
import 'package:bingo/data/models/orders/response/order_details_dto.dart';
import 'package:bingo/data/models/orders/response/order_list_dto.dart';
import 'package:bingo/domain/repositories/order_repository.dart';
import 'package:bingo/domain/repositories/template_repository.dart';
import 'package:bingo/domain/services/navigation_service/navigation_service.dart';
import 'package:bingo/presentation/dialogs/success_order/success_order_view.dart';
import 'package:crypto/crypto.dart';
import 'package:stacked/stacked.dart';

class OrderService with ListenableServiceMixin {
  final OrderRepository _orderRepository = getIt<OrderRepositoryImpl>();
  final TemplateRepository _templateRepository =
      getIt<TemplateRepositoryImpl>();

  OrderService() {
    listenToReactiveValues([
      _selectedAddress,
      _selectedCard,
      _selectedTime,
      _payByWallet,
      _pickUp,
      _payByCash,
      _userOrders,
      _unpaidOrders,
      _activeOrders,
      _completedOrders,
      _lastCreatedOrder,
      _selectedPoint,
    ]);
  }

  final ReactiveValue<AddressModel?> _selectedAddress = ReactiveValue(null);
  final ReactiveValue<AddressModel?> _selectedPoint = ReactiveValue(null);
  final ReactiveValue<GetCardResponse?> _selectedCard = ReactiveValue(null);
  final ReactiveValue<String?> _selectedTime = ReactiveValue(null);
  final ReactiveValue<bool> _payByWallet = ReactiveValue(false);
  final ReactiveValue<bool> _pickUp = ReactiveValue(false);
  final ReactiveValue<bool> _payByCash = ReactiveValue(false);
  final ReactiveValue<UserOrdersDto?> _userOrders = ReactiveValue(null);
  final ReactiveValue<UserOrdersDto?> _unpaidOrders = ReactiveValue(null);
  final ReactiveValue<UserOrdersDto?> _completedOrders = ReactiveValue(null);
  final ReactiveValue<UserOrdersDto?> _activeOrders = ReactiveValue(null);
  final ReactiveValue<OrderDetailsDto?> _lastCreatedOrder = ReactiveValue(null);

  AddressModel? get selectedAddress => _selectedAddress.value;
  AddressModel? get selectedPoint => _selectedPoint.value;
  GetCardResponse? get selectedCard => _selectedCard.value;
  String? get selectedTime => _selectedTime.value;
  bool get payByWallet => _payByWallet.value;
  bool get pickUp => _pickUp.value;
  bool get payByCash => _payByCash.value;
  UserOrdersDto? get userOrders => _userOrders.value;
  UserOrdersDto? get unpaidOrders => _unpaidOrders.value;
  UserOrdersDto? get completedOrders => _completedOrders.value;
  UserOrdersDto? get activeOrders => _activeOrders.value;
  OrderDetailsDto? get lastCreatedOrder => _lastCreatedOrder.value;

  createOrder(int? inn,) async {
    CreateOrderDto request = CreateOrderDto(
      addressId: selectedAddress?.id,
      time: selectedTime,
      pickupPointId: selectedPoint?.id,
    );
    try {
      final res = await _orderRepository.createOrder(inn,request);
      _lastCreatedOrder.value = res;
      if (res.id != null) {
        NavigationService.showCustomDialog(dialog: const SuccessOrderView());
      } else {
        // TODO NavigationService.showErrorToast("Ошибка");
      }
    } catch (e) {
      rethrow;
    }
  }

  onChooseAddress({AddressModel? address}) {
    _selectedAddress.value = address;
    _pickUp.value = false;
  }

  onChoosePoint({AddressModel? address}) {
    _pickUp.value = true;
    _selectedPoint.value = address;
  }

  onChooseTime(String time) {
    _selectedTime.value = time;
  }

  onDispose() {
    _payByCash.value = false;
    _payByWallet.value = false;
    _pickUp.value = false;
    _selectedAddress.value = null;
    _selectedCard.value = null;
    _selectedTime.value = null;
  }

  Future<void> fetchOrders(int? inn,{String? url}) async {
    try {
      final res = await _orderRepository.fetchOrders(inn,url: url);
      if (url == null) {
        _userOrders.value = res;
      } else {
        userOrders!.results!.addAll(res.results!);
        userOrders!.next = res.next;
      }
    } catch (e) {
      rethrow;
    }
  }


  Future<OrderDetailsDto> getOrder(int orderId) async {
    try {
      return await _orderRepository.fetchOrderById(orderId.toString());
    } catch (e) {
      rethrow;
    }
  }


  Future<void> createTemplateOrder(String templateId) async {
    try {
      CreateOrderDto request = CreateOrderDto(
        addressId: selectedAddress?.id,
        time: selectedTime,
        pickupPointId: selectedPoint?.id,
      );

      final res = await _templateRepository.createOrder(templateId, request);

      if (res.id != null) {
        _lastCreatedOrder.value = res;

        NavigationService.showCustomDialog(dialog: const SuccessOrderView());
      } else {
        NavigationService.showErrorToast("Ошибка");
      }
    } catch (e) {
      rethrow;
    }
  }
}
