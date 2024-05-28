import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/data/models/address/address_response.dart';
import 'package:bingo/domain/services/address_service/address_service.dart';
import 'package:bingo/domain/services/navigation_service/navigation_service.dart';
import 'package:bingo/domain/services/order_service/order_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddressSheetViewModel extends ReactiveViewModel {
  final AddressService _addressService = getIt();
  final OrderService _orderService = getIt();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_addressService, _orderService];

  AddressModel? get selectedAddress => _orderService.selectedAddress;
  late List<AddressModel> adresses;
  bool get pickUp => _orderService.pickUp;
  int? deliveryCost;

  onReady() {
    getData();
  }

  Future<void> getData() async {
    setBusy(true);
    try {
      adresses = await _addressService.fetchAddresses();
      rebuildUi();
    } catch (e) {
      NavigationService.showErrorToast(e.toString());
    }
    setBusy(false);
  }

  onChooseAddress({AddressModel? address}) async {
    _orderService.onChooseAddress(address: address);
    if (address == null) {
      Navigator.pop(
        router.navigatorKey.currentContext!,
      );
      return;
    }
  }
}
