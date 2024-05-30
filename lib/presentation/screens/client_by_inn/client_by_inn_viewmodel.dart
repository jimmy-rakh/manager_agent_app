

import 'package:bingo/domain/services/client_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../data/models/client/client.dart';
import '../../../domain/services/navigation_service/navigation_service.dart';

class ClientByInnViewModel extends ReactiveViewModel {
  final ClientService _clientService = getIt();
  @override
  List<ListenableServiceMixin> get listenableServices => [_clientService];
  Client? get client => _clientService.clientData;

  TextEditingController usernameController = TextEditingController();



  void onReady(context) {
    final currentWidth = MediaQuery.of(context).size.width;
print(currentWidth.toString());
  }

  getData() async {
    setBusy(true);
    try {
      await _clientService.getClientData(int.parse(usernameController.text));
    } catch (e) {
      NavigationService.showErrorToast(e.toString());
      setError(true);
    }
    setBusy(false);
  }

}
