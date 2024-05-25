import 'package:bingo/app/locator.dart';
import 'package:bingo/core/custom_widgets/default_sheet_parent.dart';
import 'package:bingo/data/models/address/address_response.dart';
import 'package:bingo/data/models/card/response/get_card_response.dart';
import 'package:bingo/data/models/products/response/cart_model.dart';
import 'package:bingo/data/models/template/response.dart';
import 'package:bingo/domain/services/navigation_service/navigation_service.dart';
import 'package:bingo/domain/services/order_service/order_service.dart';
import 'package:bingo/domain/services/products_service/products_service.dart';
import 'package:bingo/domain/services/templates/templates_service.dart';
import 'package:bingo/presentation/bottom_sheets/address_sheet/address_sheet_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CheckoutViewModel extends ReactiveViewModel {
  final ProductsService _productsService = getIt();
  final OrderService _orderService = getIt();
  final TemplateService _templateService = getIt();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_productsService, _orderService];

  CartDto? get cartData => _productsService.cartData;
  AddressModel? get selectedAddress => _orderService.selectedAddress;
  AddressModel? get selectedPoint => _orderService.selectedPoint;
  GetCardResponse? get selectedCard => _orderService.selectedCard;
  String? get selectedTime => _orderService.selectedTime;
  ScrollController timeScrollController = ScrollController();
  bool get byCash => _orderService.payByCash;
  bool get byWallet => _orderService.payByWallet;
  bool get pickUp => _orderService.pickUp;

  TemplateResponse? template;

  int? deliveryCost;

  void onReady(String? templateId) {
    if (templateId != null) {
      fetchTemplate(templateId);
    }
  }

  showAddressChooser() async {
    int? res = await NavigationService.showBottomSheet(
      sheet: const DefaultSheetParent(
        radius: 12,
        child: AddressSheetView(),
      ),
      isDismissible: true,
      enableDrag:true,
    );

    deliveryCost = res;
    notifyListeners();
  }

  onDispose() {
    _orderService.onDispose();
  }

  onOrder() async {
    setBusy(true);
    try {
      template == null
          ? await _orderService.createOrder()
          : await _orderService.createTemplateOrder(template!.id!);
    } catch (e) {
      print(e);
    }
    setBusy(false);
  }

  bool orderButtonStatus() {
    return pickUp || (selectedAddress != null);
  }

  Future<void> fetchTemplate(String templateId) async {
    setBusy(true);
    try {
      final res = await _templateService.fetchTemplate(templateId);
      template = res;
      rebuildUi();
    } catch (e) {
      print(e);
    }
    setBusy(false);
  }
}
