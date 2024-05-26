import 'dart:convert';

import 'package:bingo/app/locator.dart';
import 'package:bingo/core/network/constants.dart';
import 'package:bingo/core/network/globuskans_api_service.dart';
import 'package:bingo/data/models/bool_response.dart';
import 'package:bingo/data/models/devices/network/device_token_request.dart';
import 'package:bingo/data/models/devices/network/device_token_response.dart';
import 'package:bingo/data/models/user/requests/change_user_status.dart';
import 'package:bingo/data/models/user/requests/check_user.dart';
import 'package:bingo/data/models/user/requests/create_user.dart';
import 'package:bingo/data/models/user/requests/login_request.dart';
import 'package:bingo/data/models/user/response/check_user.dart';
import 'package:bingo/data/models/user/response/user_model.dart';
import 'package:bingo/data/models/user/response/balance_model.dart';

import '../../models/client/client.dart';

abstract class AuthApi {
  Future<DeviceTokenDto> registerGuestToken(RegisterDeviceTokenRequest request);

  Future<CheckUserResponse> checkUserRequest(CheckUserRequest request);

  Future<DeviceTokenDto> loginRequest(LoginRequest request);

  Future<DefaultResponse> requestCode(LoginRequest request);

  Future<UserModel> getProfileData();

  Future<Client> getClientData(int? inn);

  Future<DefaultResponse> logOut();

  Future<DefaultResponse> createUser(CreateUserRequest request);

  Future<DefaultResponse> editUserData(ChangeUserStatusRequest request);

  Future<DefaultResponse> uploadImage(String imageData);

  Future<DefaultResponse> deleteImage();

  Future<BalanceDto> fetchBalance();
}

class AuthApiImpl extends AuthApi {
  final BingoApi _bingoApi = getIt();

  @override
  Future<DeviceTokenDto> registerGuestToken(
      RegisterDeviceTokenRequest request) async {
    try {
      final res = await _bingoApi.post(NetworkConstants.fetchGuestToken,
          data: request.toJson());

      final myJson = DeviceTokenDto.fromJson(res);
      return myJson;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CheckUserResponse> checkUserRequest(CheckUserRequest request) async {
    try {
      final res = await _bingoApi.post(NetworkConstants.users,
          data: request.toJson());

      return CheckUserResponse.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DeviceTokenDto> loginRequest(LoginRequest request) async {
    try {
      final res = await _bingoApi.post(NetworkConstants.login,
          data: request.toJson());

      return DeviceTokenDto.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> getProfileData() async {
    try {
      final res = await _bingoApi.get(NetworkConstants.users);

      return UserModel.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Client> getClientData(int? inn) async {
    try {
      final res = await _bingoApi.get("${NetworkConstants.clients}$inn");

      return Client.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DefaultResponse> requestCode(LoginRequest request) async {
    try {
      final res = await _bingoApi.post(NetworkConstants.requestCode,
          data: request.toJson());

      return DefaultResponse.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DefaultResponse> logOut() async {
    try {
      final res = await _bingoApi.delete(NetworkConstants.logOut);
      return DefaultResponse.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DefaultResponse> createUser(CreateUserRequest request) async {
    try {
      final res = await _bingoApi.post(NetworkConstants.createUser,
          data: request.toJson());
      return DefaultResponse.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DefaultResponse> editUserData(ChangeUserStatusRequest request) async {
    try {
      final res = await _bingoApi.patch(NetworkConstants.users,
          data: request.toJson());

      return DefaultResponse.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DefaultResponse> uploadImage(String imageData) async {
    try {
      final res = await _bingoApi.post(NetworkConstants.uploadImage,
          data: jsonEncode({'image': imageData}));
      return DefaultResponse.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DefaultResponse> deleteImage() async {
    try {
      final res = await _bingoApi.delete(
        NetworkConstants.uploadImage,
      );
      return DefaultResponse.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BalanceDto> fetchBalance() async {
    try {
      final res = await _bingoApi.get(NetworkConstants.balance);
      return BalanceDto.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }
}
