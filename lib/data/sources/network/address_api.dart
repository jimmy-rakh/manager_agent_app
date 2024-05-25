import 'dart:convert';

import 'package:bingo/app/locator.dart';
import 'package:bingo/core/network/constants.dart';
import 'package:bingo/core/network/globuskans_api_service.dart';
import 'package:bingo/data/models/address/add_address_request.dart';
import 'package:bingo/data/models/address/address_response.dart';

abstract class AddressApi {
  Future<List<AddressModel>> fetchAddress();

  Future<void> addAddress(AddAddressRequestModel request);

  Future<void> deleteAddress(int addressId);

  Future<List<AddressModel>> fetchPoints();
}

class AddressApiImpl implements AddressApi {
  final BingoApi _bingoApi = getIt();

  @override
  Future<List<AddressModel>> fetchAddress() async {
    try {
      final res = await _bingoApi.get(NetworkConstants.address);
      final myList =
          List.from(res['delivery_addresses']).map((e) => AddressModel.fromJson(e)).toList();
      return myList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addAddress(AddAddressRequestModel request) async {
    try {
      await _bingoApi.post(NetworkConstants.address, data: request.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAddress(int addressId) async {
    final request = {'address_id': addressId};
    try {
      await _bingoApi.delete(NetworkConstants.address,
          data: jsonEncode(request));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AddressModel>> fetchPoints() async {
    try {
      final res = await _bingoApi.get(NetworkConstants.points);

      final data = List.from(res).map((e) => AddressModel.fromJson(e)).toList();
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
