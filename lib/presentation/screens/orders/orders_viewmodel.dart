import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/core/enum/user_status.dart';
import 'package:bingo/domain/services/auth_service/auth_service.dart';
import 'package:bingo/domain/services/navigation_service/navigation_service.dart';
import 'package:bingo/domain/services/order_service/order_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../data/models/orders/response/orders.dart';
import '../../../domain/services/client_service.dart';

class OrdersScreenModel extends ReactiveViewModel {
  final AuthService _authService = getIt();
  final OrderService _orderService = getIt();
  final ClientService _clientService = getIt();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_authService, _orderService,_clientService];

  int? get inn => _clientService.inn;

  late TabController tabController;
  late PageController pageController;
  ScrollController scrollController = ScrollController();
  UserStatus get userStatus => _authService.userStatus;
  OrdersDto? get userOrders => _orderService.userOrders;
  OrdersDto? get activeOrders => _orderService.activeOrders;
  OrdersDto? get completedOrders => _orderService.completedOrders;

  onReady({TickerProvider? mixin}) async {
    if (mixin != null) tabController = TabController(length: 3, vsync: mixin);
    pageController = PageController(initialPage: tabController.index);
    await fetchOrders();
    if (userOrders == null) {
      return;
    }
    debugPrint(userOrders?.next);
    scrollController.addListener(() {
      if (scrollController.position.extentAfter < 100 &&
          !isBusy &&
          userOrders?.next != null) {
        loadMore();
      }
    });
  }

  void onPageChanged(int page) {
    tabController.animateTo(page);
    tabController.index = page;
    notifyListeners();
  }

  void onTabTapped(int tab) {
    pageController.animateToPage(tab,
        curve: Curves.ease, duration: const Duration(milliseconds: 500));
    tabController.index = tab;
    notifyListeners();
  }

  fetchOrders() async {
    try {
      await _orderService.fetchOrders(inn);

    } catch (e) {
      NavigationService.showErrorToast(e.toString());
    }
  }

  toOrderView(int orderId) {
    router.navigate(OrdersOrderRoute(orderId: orderId));
  }

  loadMore() async {
    setBusy(true);
    try {
      switch (tabController.index) {
        case 0:
          await _orderService.fetchOrders(inn,url: userOrders?.next);
          break;
        default:
          await _orderService.fetchOrders(inn,url: userOrders?.next);
      }
    } catch (e) {
      NavigationService.showErrorToast(e.toString());
    }
    setBusy(false);
  }
}
