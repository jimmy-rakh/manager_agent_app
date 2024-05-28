import 'package:bingo/app/locator.dart';
import 'package:bingo/data/models/address/address_response.dart';
import 'package:bingo/domain/repositories/address_repository.dart';
import 'package:stacked/stacked.dart';

class AddressService with ListenableServiceMixin {
  final _addressRepository = getIt<AddressRepositoryImpl>();

  AddressService() {
    listenToReactiveValues([]);
  }

  final defLocation = const SamarkandLocation();

  Future<void> searchAddress(
      {double? lat, double? lon, String? address, String? query}) async {}

  Future<List<AddressModel>> fetchAddresses(int? inn) async {
    try {
      return await _addressRepository.fetchAddress(inn);
    } catch (e) {
      rethrow;
    }
  }
}

class AppLatLong {
  final double lat;
  final double long;

  const AppLatLong({
    required this.lat,
    required this.long,
  });
}

class SamarkandLocation extends AppLatLong {
  const SamarkandLocation({
    super.lat = 41.29589431188876,
    super.long = 69.24296267346423,
  });
}
