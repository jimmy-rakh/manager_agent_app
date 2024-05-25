import 'package:bingo/app/locator.dart';
import 'package:bingo/core/network/constants.dart';
import 'package:bingo/data/sources/local/storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'interceptor.dart';

class DioClient {
  final LocalStorage _localStorage = getIt<LocalStorageImpl>();

  String? get locale => _localStorage.getLocale();

  static Dio okansDio = _createDio();
  static Dio? _okansDio;

  static final okansDioOptions = BaseOptions(
      baseUrl: NetworkConstants.baseApiUrl,
      connectTimeout: NetworkConstants.connectTimeout,
      receiveTimeout: NetworkConstants.receiveTimeout,
      // queryParameters: {
      //   'lang': NavigationService
      //           .navigatorKey.currentContext?.locale.languageCode ??
      //       'ru'
      // },
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization':
            'GlogusRest 23298eed6d23382b789b605ff21cfa74647edf01115366a9224fb22a39ad2c6f'
      },
      responseType: ResponseType.json);

  static final logInterceptor = LogInterceptor(
      request: true,
      responseBody: true,
      requestBody: true,
      requestHeader: true,
      logPrint: _debugPrint);

  static Dio _createDio() {
    _okansDio ??= Dio(okansDioOptions)
      ..interceptors.addAll([CustomInterceptor(), logInterceptor]);
    return _okansDio!;
  }

  static void toggleMultipartFormData(bool isOn) {
    if (isOn) {
      okansDio.options.headers['Content-Type'] = 'multipart/form-data';
    } else {
      okansDio.options.headers['Content-Type'] =
          'application/json; charset=utf-8';
    }
  }

  static void setDeviceId(String? deviceId) {
    if (deviceId == null) {
      okansDio.options.headers.remove('Device-id');
    } else {
      okansDio.options.headers['Device-id'] = deviceId;
    }
  }

  static void setSessionKey(String? sessionKey) {
    if (sessionKey == null) {
      okansDio.options.headers.remove('Session-key');
    } else {
      okansDio.options.headers['Session-key'] = sessionKey;
    }
  }

  static void setAccessToken(String? token) {
    if (token == null) {
      okansDio.options.headers.remove('User-Token');
    } else {
      okansDio.options.headers['User-Token'] = token;
    }
  }

  static void setConfirmCode(int? code) {
    if (code == null) {
      okansDio.options.headers.remove('confirm-code');
    } else {
      okansDio.options.headers['confirm-code'] = code;
    }
  }

  static void setLanguage(String? languageCode) {
    if (languageCode == null) {
      okansDio.options.headers.remove('Accept-Language');
    } else {
      okansDio.options.headers['Accept-Language'] = languageCode;
    }
  }

  static void setCurrency(String? currency) {
    if (currency == null) {
      okansDio.options.headers.remove('User-Currency');
    } else {
      okansDio.options.headers['User-Currency'] = currency;
    }
  }

  static void _debugPrint(Object object) {
    debugPrint(object.toString());
  }
}
