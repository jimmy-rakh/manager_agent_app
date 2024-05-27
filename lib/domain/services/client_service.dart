import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../data/models/client/client.dart';
import '../repositories/auth_repository.dart';

class ClientService  with ListenableServiceMixin{
  final _authRepository = getIt<AuthRepositoryImpl>();

  final ReactiveValue<Client?> _clientData = ReactiveValue(null);
  Client? get clientData => _clientData.value;
  int? inn;
  ClientService() {
    listenToReactiveValues(
        [ _clientData,]);
  }

  Future<Client> getClientData(int? inn) async {
    try {
     final  res = await _authRepository.getClientData(inn);
      _clientData.value = res;
     this.inn = inn;
     return res;
    } catch (e) {
      rethrow;
    }
  }
}