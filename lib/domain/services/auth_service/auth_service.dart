import 'dart:convert';
import 'dart:io';

import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/core/enum/user_status.dart';
import 'package:bingo/core/network/dio_client.dart';
import 'package:bingo/core/utils/device_info.dart';
import 'package:bingo/core/utils/user_types.dart';
import 'package:bingo/data/models/bool_response.dart';
import 'package:bingo/data/models/devices/device.dart';
import 'package:bingo/data/models/devices/network/device_token_response.dart';
import 'package:bingo/data/models/user/requests/change_user_status.dart';
import 'package:bingo/data/models/user/requests/check_user.dart';
import 'package:bingo/data/models/user/requests/create_user.dart';
import 'package:bingo/data/models/user/requests/login_request.dart';
import 'package:bingo/data/models/user/response/user_model.dart';
import 'package:bingo/data/models/user/response/user_requests.dart';
import 'package:bingo/data/models/user/response/balance_model.dart';
import 'package:bingo/domain/repositories/auth_repository.dart';
import 'package:bingo/domain/services/notification_service/notification_service.dart';
import 'package:bingo/presentation/screens/client_by_inn/client_by_inn_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AuthService with ListenableServiceMixin {
  final _authRepository = getIt<AuthRepositoryImpl>();
  final _notficationService = getIt<NotificationService>();

  final ReactiveValue<bool> _isUserExist = ReactiveValue(false);
  final ReactiveValue<bool> _isUserBanned = ReactiveValue(false);
  final ReactiveValue<UserModel?> _userData = ReactiveValue(null);
  final ReactiveValue<BalanceDto?> _balance = ReactiveValue(null);
  final ReactiveValue<List<UserRequestsDto>> _userRequests = ReactiveValue([]);

  bool get isUserExist => _isUserExist.value;
  bool get isUserBanned => _isUserBanned.value;
  UserModel? get userData => _userData.value;
  BalanceDto? get balance => _balance.value;
  List<UserRequestsDto> get userRequests => _userRequests.value;

  UserStatus get userStatus => _authRepository.getUserStatus();

  AuthService() {
    listenToReactiveValues(
        [_isUserExist, _userData, _isUserBanned, _balance, _userRequests]);
  }

  void setUserStatus(UserStatus userStatus) {
    _authRepository.setUserStatus(userStatus);
  }

  setLanguage(String locale) {
    router.navigatorKey.currentContext!.setLocale(Locale(locale));
    DioClient.setLanguage(locale);
    _authRepository.setlanguage(locale);
  }

  String? getDeviceToken() {
    final token = _authRepository.getDeviceToken();
    return token;
  }

  UserStatus getUserStatus() {
    final userStatus = _authRepository.getUserStatus();
    return userStatus;
  }

  Future<void> checkUserRequest(String phoneNumber) async {
    CheckUserRequest request = CheckUserRequest(phoneNumber: phoneNumber);
    try {
      final res = await _authRepository.checkUserRequest(request);

      _isUserExist.value = res.loged!;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logIn(String username, String password) async {
    Device myDevice = await DeviceInfo.getDeviceData();
    final fcm = await _notficationService.getFcmToken();
    LoginRequest request = LoginRequest(
        username: username,
        password: password,
        fcmToken: fcm!,
        device: myDevice);
    try {
      DeviceTokenDto res = await _authRepository.loginRequest(request);

      if (res.deviceToken.isNotEmpty) {
        _authRepository.setUserStatus(UserStatus.authorized);
        _authRepository.setDeviceToken(res.deviceToken);
        await getProfileData();
        router.replace(const ClientByInnRoute());
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getProfileData() async {
    try {
      _userData.value = await _authRepository.getProfileData();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createUser(String phone, String name, String surname,
      String lastName, String code) async {
    CreateUserRequest request = CreateUserRequest(
        type: UserTypes.USER_RETAIL.name,
        phoneNumber: phone,
        name: name,
        surname: surname,
        lastname: lastName,
        code: code);
    try {
      final res = await _authRepository.createUser(request);
      if (res.success) {
        _authRepository.setUserStatus(UserStatus.authorized);
        await getProfileData();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<DefaultResponse> editUserData(ChangeUserStatusRequest request) async {
    try {
      return await _authRepository.editUserData(request);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> uploadImage(File file) async {
    // final crop = cropKey.currentState;
    // final area = crop!.area;
    // final sampledFile = await ImageCrop.sampleImage(
    //   file: File(file.path),
    //   preferredWidth: 1024,
    //   preferredHeight: 1024,
    // );

    // final croppedFile = await ImageCrop.cropImage(
    //   file: sampledFile,
    //   area: area!,
    // );
    try {
      final res = await _authRepository.uploadImage(
          "data:image/png;base64,${base64Encode(file.readAsBytesSync())}");
      if (res.success) {
        await getProfileData();
        // TODO NavigationService.back();
      } else {
        // TODO NavigationService.showErrorToast(
        //     'Не удалось загрузить фотографию попробуйте еще раз!');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteImage() async {
    try {
      final res = await _authRepository.deleteImage();
      if (res.success) {
        await getProfileData();
        // TODO Navigator.pop(NavigationService.navigatorKey.currentContext!);
      } else {
        // TODO NavigationService.showErrorToast(
        //     'Не удалось удалить фотографию попробуйте еще раз!');
      }
    } catch (e) {
      rethrow;
    }
  }

  logOut() async {
    try {
      await _authRepository.logOut();
      _userData.value = null;
      // TODO NavigationService.newRootScreen(Routes.splashScreen);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchBalance() async {
    try {
      final res = await _authRepository.fetchBalance();
      _balance.value = res;
    } catch (e) {
      rethrow;
    }
  }
}
