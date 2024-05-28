import 'package:bingo/app/locator.dart';
import 'package:bingo/domain/services/address_service/address_service.dart';
import 'package:bingo/domain/services/navigation_service/navigation_service.dart';
import 'package:stacked/stacked.dart';

class AddressScreenViewModel extends ReactiveViewModel {
  final AddressService _addressService = getIt();

  @override
  List<ListenableServiceMixin> get listenableServices => [_addressService];


  onReady() {
    getData();
  }

  getData() async {
    setBusy(true);
    try {
      // await _addressService.fetchAddresses();
    } catch (e) {
      NavigationService.showErrorToast(e.toString());
    }
    setBusy(false);
  }


}
