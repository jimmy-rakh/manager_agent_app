import 'package:auto_route/auto_route.dart';
import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/core/enum/user_status.dart';
import 'package:bingo/data/models/user/response/user_model.dart';
import 'package:bingo/data/models/user/response/balance_model.dart';
import 'package:bingo/domain/services/auth_service/auth_service.dart';
import 'package:bingo/domain/services/navigation_service/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart' hide PageRouteInfo;
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/search/search_request.dart';
import '../../../data/models/search/search_response.dart';

class AccountViewModel extends ReactiveViewModel {
  final AuthService _authService = getIt();

  @override
  List<ListenableServiceMixin> get listenableServices => [_authService];

  UserStatus get userStatus => _authService.userStatus;
  UserModel? get userData => _authService.userData;
  BalanceDto? get balance => _authService.balance;
  final TextEditingController searchController = TextEditingController();
  bool isSearched = false;
  bool showSearchHistory = true;

  SearchResponse? searchedValues;

  FocusNode searchFocusNode = FocusNode();

  late SearchRequest searchRequest;

  late SearchRequest? specificSearchRequest;
  onReady() {
    getData();
  }


  getData() async {
    if (userStatus != UserStatus.authorized) return;
    setBusy(true);
    try {
      await _authService.getProfileData();
    } catch (e) {
      NavigationService.showErrorToast(e.toString());
      setError(true);
    }
    setBusy(false);
  }

  logOut() async {
    try {
      await _authService.logOut();
    } catch (e) {
      NavigationService.showErrorToast(e.toString());
    }
  }

  toPage(PageRouteInfo route) async {
    router.navigate(route);
    // await NavigationService.pushNamed(
    //   navIndex: 4,
    //   routeName: page,
    // ).then((value) => getData());
  }

  openTg() {
    launchUrl(Uri(scheme: 'tel', path: "+998931011905"));
  }
}
