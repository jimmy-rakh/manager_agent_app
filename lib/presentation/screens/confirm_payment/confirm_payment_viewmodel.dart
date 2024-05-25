import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/data/models/card/response/get_card_response.dart';
import 'package:bingo/data/models/user/response/balance_model.dart';
import 'package:bingo/domain/services/auth_service/auth_service.dart';
import 'package:bingo/domain/services/card_service/card_service.dart';
import 'package:bingo/domain/services/order_service/order_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../data/models/orders/response/order_details_dto.dart';

class ConfirmPaymentViewModel extends ReactiveViewModel {
  final CardService _cardService = getIt();
  final OrderService _orderService = getIt();
  final AuthService _authService = getIt();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_cardService, _orderService, _authService];

  List<GetCardResponse> get cardsList => _cardService.cardsList;
  GetCardResponse? selectedCard;
  bool withCash = false;
  bool withBalance = false;
  BalanceDto? get balance => _authService.balance;
  late int orderId;
  OrderDetailsDto? order;

  void onReady(int orderId) {
    this.orderId = orderId;
    getOrder();
    getCards();
    print('${balance?.balance}');

  }

  Future<void> getCards() async {
    try {
      await _cardService.getCards();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getOrder() async {
    setBusy(true);
    try {
     final  res = await _orderService.getOrder(orderId);
     order = res;
    } catch (e) {
      print(e);
    }
    setBusy(false);
  }

  void chooseMethod({
    GetCardResponse? card,
    bool withCash = false,
    bool withBalance = false,
  }) {
    selectedCard = card;
    this.withCash = withCash;
    this.withBalance = withBalance;
    notifyListeners();
  }

  bool buttonCondition() {
    if (withBalance) return balance!.limit! > 2300000;
    return selectedCard != null || withCash;
  }

  void onPay() async {
    try {
      await _orderService.paySubmit(
          orderId: orderId,
          cardId: selectedCard?.id,
          byCash: withCash,
          byTransfer: withBalance);
      _orderService.fetchOrders();
      Navigator.pop(router.navigatorKey.currentContext!, true);
    } catch (e) {
      print(e);
    }
  }
}
