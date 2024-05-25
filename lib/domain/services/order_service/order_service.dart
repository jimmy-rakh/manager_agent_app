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

  createOrder() async {
    CreateOrderDto request = CreateOrderDto(
      addressId: selectedAddress?.id,
      time: selectedTime,
      pickupPointId: selectedPoint?.id,
    );
    try {
      final res = await _orderRepository.createOrder(request);
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

  onChooseCard({GetCardResponse? card, bool? wallet}) {
    if (card != null) {
      _selectedCard.value = card;
      _payByWallet.value = false;
      _payByCash.value = false;
    } else if (wallet != null) {
      _selectedCard.value = null;
      _payByWallet.value = true;
      _payByCash.value = false;
    } else {
      _payByCash.value = true;
      _payByWallet.value = false;
      _selectedCard.value = null;
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

  Future<void> fetchOrders({String? url}) async {
    try {
      final res = await _orderRepository.fetchOrders(url: url);
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

  Future<void> fetchUnpaidOrders({String? url}) async {
    try {
      final res =
          await _orderRepository.fetchOrders(url: url, status: 'WAITPAY');
      if (url == null) {
        _unpaidOrders.value = res;
      } else {
        unpaidOrders!.results!.addAll(res.results!);
        unpaidOrders!.next = res.next;
      }
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> fetchActiveOrders({String? url}) async {
  //   try {
  //     final res =
  //         await _orderRepository.fetchOrders(url: url, status: 'ACTIVE');
  //     if (url == null) {
  //       _activeOrders.value = res;
  //     } else {
  //       activeOrders!.results!.addAll(res.results!);
  //       activeOrders!.next = res.next;
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
  //
  // Future<void> fetchCompletedOrders({String? url}) async {
  //   try {
  //     final res =
  //         await _orderRepository.fetchOrders(url: url, status: 'COMPLETED');
  //     if (url == null) {
  //       _completedOrders.value = res;
  //     } else {
  //       completedOrders!.results!.addAll(res.results!);
  //       completedOrders!.next = res.next;
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<OrderDetailsDto> getOrder(int orderId) async {
    try {
      return await _orderRepository.fetchOrderById(orderId.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> submitOrderById(int orderId) async {
    try {
      await _orderRepository.submitOrderById(orderId.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> cancelOrderById(int orderId) async {
    try {
      await _orderRepository.cancelOrderById(orderId.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addReview(
      {required int productId,
      required String comment,
      required int rating}) async {
    final AddReviewRequest request = AddReviewRequest(
        productId: productId, comment: comment, rating: rating);
    try {
      await _orderRepository.addReview(request);
    } catch (e) {
      rethrow;
    }
  }

  Future<DeliveryCostDto> fetchDeliveryCost(int addressId) async {
    try {
      return await _orderRepository.fetchDeliveryCost(addressId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> paySubmit(
      {required int orderId,
      String? cardId,
      bool? byCash,
      bool? byTransfer}) async {
    final data = PaySubmitModel(
        orderId: orderId,
        cardId: cardId,
        byCash: byCash,
        byTransfer: byTransfer);
    try {
      await _orderRepository.paySubmit(data);
    } catch (e) {
      rethrow;
    }
  }

  confirmOrder(int orderId, String data) async {
    var key = utf8.encode('order_id=$orderId');

    final hexString = data.replaceAll("-", "");
    final bytePairs = hexString.split('');

    String result = "";
    for (var i = 0; i < bytePairs.length; i += 2) {
      final bytePair = bytePairs.sublist(i, i + 2);
      final byteValue = int.parse(bytePair.join(), radix: 16);
      result += byteValue.toRadixString(16).padLeft(2, '0');
    }
    var bytes = utf8.encode('hash=$result');
    var hmacSha256 = Hmac(sha256, key);
    var digest = hmacSha256.convert(bytes);
    ConfirmOrderRequest request =
        ConfirmOrderRequest(sign: '$digest', orderId: orderId);

    try {
      await _orderRepository.confirmOrder(request);
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
