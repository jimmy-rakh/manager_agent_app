import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/core/enum/user_status.dart';
import 'package:bingo/data/models/bool_response.dart';
import 'package:bingo/data/models/devices/network/device_token_response.dart';
import 'package:bingo/data/models/user/requests/change_user_status.dart';
import 'package:bingo/data/models/user/requests/check_user.dart';
import 'package:bingo/data/models/user/requests/create_user.dart';
import 'package:bingo/data/models/user/requests/login_request.dart';
import 'package:bingo/data/models/user/response/check_user.dart';
import 'package:bingo/data/models/user/response/user_model.dart';
import 'package:bingo/data/models/user/response/balance_model.dart';
import 'package:bingo/data/sources/local/storage.dart';
import 'package:bingo/data/sources/network/auth_api.dart';

import '../../data/models/client/client.dart';

abstract class AuthRepository {
  UserStatus getUserStatus();

  void setUserStatus(UserStatus userStatus);

  void setlanguage(String locale);

  void setDeviceToken(String deviceToken);

  String? getDeviceToken();

  Future<CheckUserResponse> checkUserRequest(CheckUserRequest request);

  Future<DeviceTokenDto> loginRequest(LoginRequest request);

  Future<DefaultResponse> requestCode(LoginRequest request);

  Future<UserModel> getProfileData();

  Future<Client> getClientData(int? inn);

  Future<DefaultResponse> createUser(CreateUserRequest request);

  Future<DefaultResponse> editUserData(ChangeUserStatusRequest request);

  Future<DefaultResponse> uploadImage(String imageData);

  Future<DefaultResponse> deleteImage();

  Future<DefaultResponse> logOut();

  Future<BalanceDto> fetchBalance();
}

class AuthRepositoryImpl implements AuthRepository {
  final _localStorage = getIt<LocalStorageImpl>();
  final _authApi = getIt<AuthApiImpl>();

  @override
  UserStatus getUserStatus() {
    return _localStorage.getUserStatus();
  }

  @override
  void setUserStatus(UserStatus userStatus) {
    _localStorage.setUserStatus(userStatus);
  }

  @override
  void setlanguage(String locale) {
    _localStorage.setLocale(locale);
  }

  @override
  void setDeviceToken(String deviceToken) {
    _localStorage.setDeviceToken(deviceToken);
  }

  @override
  String? getDeviceToken() {
    return _localStorage.getDeviceToken();
  }

  @override
  Future<CheckUserResponse> checkUserRequest(CheckUserRequest request) async {
    try {
      return await _authApi.checkUserRequest(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DeviceTokenDto> loginRequest(LoginRequest request) async {
    try {
      return await _authApi.loginRequest(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> getProfileData() async {
    try {
      return await _authApi.getProfileData();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Client> getClientData(int? inn) async {
    try {
      return await _authApi.getClientData(inn);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DefaultResponse> requestCode(LoginRequest request) async {
    try {
      return await _authApi.requestCode(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DefaultResponse> createUser(CreateUserRequest request) async {
    try {
      return await _authApi.createUser(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DefaultResponse> editUserData(ChangeUserStatusRequest request) async {
    try {
      return await _authApi.editUserData(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DefaultResponse> uploadImage(String imageData) async {
    try {
      return await _authApi.uploadImage(imageData);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DefaultResponse> deleteImage() async {
    try {
      return await _authApi.deleteImage();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DefaultResponse> logOut() async {
    try {
      final res = await _authApi.logOut();
      if (res.success) {
        await _localStorage.clear();
        router.replaceAll([const SplashRoute()]);
      }
      return res;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BalanceDto> fetchBalance() async {
    try {
      return await _authApi.fetchBalance();
    } catch (e) {
      rethrow;
    }
  }
}
