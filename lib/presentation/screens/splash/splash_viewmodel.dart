import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/core/enum/user_status.dart';
import 'package:bingo/core/network/dio_client.dart';
import 'package:bingo/data/sources/local/storage.dart';
import 'package:bingo/domain/services/auth_service/auth_service.dart';
import 'package:bingo/presentation/screens/client_by_inn/client_by_inn_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends ReactiveViewModel {
  final AuthService _authService = getIt();
  final LocalStorage _localStorage = getIt<LocalStorageImpl>();
  @override
  List<ListenableServiceMixin> get listenableServices => [_authService];

  UserStatus get userStatus => _authService.getUserStatus();
  String? get token => _authService.getDeviceToken();

  onReady() async {
    setBusy(true);
    await Future.delayed(const Duration(milliseconds: 500));
    DioClient.setLanguage(_localStorage.getLocale());
    nextPage();
    setBusy(false);
  }

  nextPage() {
    switch (userStatus) {
      case UserStatus.notAuthorized:
        router.replace(const LoginRoute());
        break;
      default:
        router.replace(const ClientByInnRoute());
    }
  }
}
