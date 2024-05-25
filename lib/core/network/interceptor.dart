import 'package:dio/dio.dart';

class CustomInterceptor extends Interceptor {
  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      // NavigationService.showErrorToast('common.low_internet_connection'.tr());
      return handler.next(err);
    } else {
      // NavigationService.showErrorToast('Упс... Что-то пошло не так');
    }
    return handler.next(err);
  }
}
