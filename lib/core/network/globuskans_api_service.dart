import 'package:bingo/app/locator.dart';
import 'package:bingo/data/sources/local/storage.dart';
import 'package:dio/dio.dart';
import 'dio_client.dart';

class BingoApi {
  final LocalStorage _localStorage = getIt<LocalStorageImpl>();

  String? get locale => _localStorage.getLocale();
  String? get deviceToken => _localStorage.getDeviceToken();

  // Get
  Future<dynamic> get(
    String uri, {
    token,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await DioClient.okansDio.get(
        uri,
        queryParameters: queryParameters,
        options: Options(headers: {
          if (locale != null) 'Accept-Language': locale,
          if (deviceToken != null) 'Device-Token': 'Okans ${deviceToken!}',
          'Authorization': 'GlogusRest 23298eed6d23382b789b605ff21cfa74647edf01115366a9224fb22a39ad2c6f'
        }),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Post
  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await DioClient.okansDio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: {
          if (locale != null) 'Accept-Language': locale,
          if (deviceToken != null) 'Device-Token': 'Okans ${deviceToken!}',
          'Authorization': 'GlogusRest 23298eed6d23382b789b605ff21cfa74647edf01115366a9224fb22a39ad2c6f'
        }),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Put
  Future<dynamic> put(
    String uri, {
    token,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await DioClient.okansDio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: {
          if (locale != null) 'Accept-Language': locale,
          if (deviceToken != null) 'Device-Token': 'Okans ${deviceToken!}',
          'Authorization': 'GlogusRest 23298eed6d23382b789b605ff21cfa74647edf01115366a9224fb22a39ad2c6f'
        }),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Patch
  Future<dynamic> patch(
    String uri, {
    token,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await DioClient.okansDio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: {
          if (locale != null) 'Accept-Language': locale,
          if (deviceToken != null) 'Device-Token': 'Okans ${deviceToken!}',
          'Authorization': 'GlogusRest 23298eed6d23382b789b605ff21cfa74647edf01115366a9224fb22a39ad2c6f'
        }),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Delete
  Future<dynamic> delete(
    String uri, {
    token,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await DioClient.okansDio.delete(
        uri,
        data: data,
        options: Options(headers: {
          if (locale != null) 'Accept-Language': locale,
          if (deviceToken != null) 'Device-Token': 'Okans ${deviceToken!}',
          'Authorization': 'GlogusRest 23298eed6d23382b789b605ff21cfa74647edf01115366a9224fb22a39ad2c6f'
        }),
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
