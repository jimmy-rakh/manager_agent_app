import 'package:auto_route/auto_route.dart';
import 'package:bingo/app/locator.dart';
import 'package:bingo/data/models/categories/catigories_dto.dart';
import 'package:bingo/data/models/orders/response/order_details_dto.dart';
import 'package:bingo/data/models/products/response/product_model.dart';
import 'package:bingo/data/models/template/response.dart';
import 'package:bingo/presentation/screens/account/account_screen.dart';
import 'package:bingo/presentation/screens/account/pages/address/address_screen.dart';
import 'package:bingo/presentation/screens/account/pages/favorites/favorites_screen.dart';
import 'package:bingo/presentation/screens/account/pages/settings/settings_screen.dart';
import 'package:bingo/presentation/screens/account/pages/user_info/userinfo_screen.dart';
import 'package:bingo/presentation/screens/cart/cart_screen.dart';
import 'package:bingo/presentation/screens/categories/categories_screen.dart';
import 'package:bingo/presentation/screens/checkout/checkout_screen.dart';
import 'package:bingo/presentation/screens/confirm_payment/confirm_payment_screen.dart';
import 'package:bingo/presentation/screens/home/home_screen.dart';
import 'package:bingo/presentation/screens/login/login_screen.dart';
import 'package:bingo/presentation/screens/nav_bar/navbar_screen.dart';
import 'package:bingo/presentation/screens/nav_bar/routers/account/account_router.dart';
import 'package:bingo/presentation/screens/nav_bar/routers/cart/cart_router.dart';
import 'package:bingo/presentation/screens/nav_bar/routers/category/categories_router.dart';
import 'package:bingo/presentation/screens/nav_bar/routers/home/home_router.dart';
import 'package:bingo/presentation/screens/nav_bar/routers/orders/orders_router.dart';
import 'package:bingo/presentation/screens/nested/nested_order/orders_order_screen.dart';
import 'package:bingo/presentation/screens/nested/nested_product/cart_product_screen.dart';
import 'package:bingo/presentation/screens/nested/nested_product/category_product_screen.dart';
import 'package:bingo/presentation/screens/nested/nested_product/home_product_screen.dart';
import 'package:bingo/presentation/screens/nested/nested_product/orders_product_screen.dart';
import 'package:bingo/presentation/screens/order_details/order_details_view.dart';
import 'package:bingo/presentation/screens/orders/orders_view.dart';
import 'package:bingo/presentation/screens/product/product_page.dart';
import 'package:bingo/presentation/screens/scanner/scanner_screen.dart';
import 'package:bingo/presentation/screens/selector/selector_screen.dart';
import 'package:bingo/presentation/screens/specific_products/specific_products_view.dart';
import 'package:bingo/presentation/screens/splash/splash_screen.dart';
import 'package:bingo/presentation/screens/template/template_screen.dart';
import 'package:flutter/material.dart';

import '../presentation/screens/client_by_inn/client_by_inn_screen.dart';

part 'router.gr.dart';

final router = getIt<AppRouter>();

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        CustomRoute(
            page: LoginRoute.page,
            transitionsBuilder: TransitionsBuilders.noTransition),
        AutoRoute(page: ClientByInnRoute.page),
        AutoRoute(page: NavBarRoute.page, children: [
          AutoRoute(page: HomeRouterRoute.page, children: [
            AutoRoute(path: '', page: HomeRoute.page),
            AutoRoute(page: HomeProductRoute.page)
          ]),
          AutoRoute(page: CategoriesRouterRoute.page, children: [
            AutoRoute(path: '', page: CategoriesRoute.page),
            AutoRoute(page: CategoryProductRoute.page),
            AutoRoute(page: SpecificProductsRoute.page),
          ]),
          AutoRoute(page: CartRouterRoute.page, children: [
            AutoRoute(path: '', page: CartRoute.page),
            AutoRoute(page: CartProductRoute.page)
          ]),
          AutoRoute(page: OrdersRouterRoute.page, children: [
            AutoRoute(path: '', page: OrdersRoute.page),
            AutoRoute(page: OrdersProductRoute.page),
            AutoRoute(page: OrdersOrderRoute.page)
          ]),
          AutoRoute(page: AccountRouterRoute.page, children: [
            AutoRoute(path: '', page: AccountRoute.page),
            AutoRoute(page: UserInfoRoute.page),
            AutoRoute(page: AddressRoute.page),
            AutoRoute(page: FavoritesRoute.page),
            AutoRoute(page: SettingsRoute.page),
          ]),
        ]),
        AutoRoute(page: CheckoutRoute.page),
        AutoRoute(page: ProductRoute.page),
        AutoRoute(page: TemplateRoute.page),
        AutoRoute(page: OrderDetailsRoute.page),
        AutoRoute(page: ConfirmPaymentRoute.page),
        AutoRoute(
          page: SelectorRoute.page,
          fullscreenDialog: true,
        ),
        CustomRoute(
          page: ScannerRoute.page,
          fullscreenDialog: true,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
      ];
}
