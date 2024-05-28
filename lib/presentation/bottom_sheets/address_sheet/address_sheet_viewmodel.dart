import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/data/models/address/address_response.dart';
import 'package:bingo/domain/services/address_service/address_service.dart';
import 'package:bingo/domain/services/navigation_service/navigation_service.dart';
import 'package:bingo/domain/services/order_service/order_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../domain/services/client_service.dart';

class AddressSheetViewModel extends ReactiveViewModel {
  final AddressService _addressService = getIt();
  final OrderService _orderService = getIt();
  final ClientService _clientService = getIt();
  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_addressService, _orderService, _clientService];

  AddressModel? get selectedAddress => _orderService.selectedAddress;
  int? get inn => _clientService.inn;
  late List<AddressModel> adresses;
  bool get pickUp => _orderService.pickUp;
  int? deliveryCost;

  onReady() {
    getData();
  }

  Future<void> getData() async {
    setBusy(true);
    try {
      adresses = await _addressService.fetchAddresses(inn);
      rebuildUi();
    } catch (e) {
      NavigationService.showErrorToast(e.toString());
    }
    setBusy(false);
  }

  onChooseAddress({AddressModel? address}) async {
    _orderService.onChooseAddress(address: address);

  }
}
