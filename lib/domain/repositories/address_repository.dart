import 'package:bingo/app/locator.dart';
import 'package:bingo/data/models/address/add_address_request.dart';
import 'package:bingo/data/models/address/address_response.dart';
import 'package:bingo/data/sources/network/address_api.dart';

abstract class AddressRepository {
  Future<List<AddressModel>> fetchAddress(int? inn);

  Future<void> addAddress(AddAddressRequestModel request);

  Future<void> deleteAddress(int addressId);

  Future<List<AddressModel>> fetchPoints();
}

class AddressRepositoryImpl implements AddressRepository {
  final AddressApi _addressApi = getIt<AddressApiImpl>();

  @override
  Future<void> addAddress(AddAddressRequestModel request) async {
    try {
      final response = await _addressApi.addAddress(request);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAddress(int addressId) async {
    try {
      final response = await _addressApi.deleteAddress(addressId);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AddressModel>> fetchAddress(int? inn) async {
    try {
      final response = await _addressApi.fetchAddress(inn);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AddressModel>> fetchPoints() async {
    try {
      final response = await _addressApi.fetchPoints();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
