// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AccountRouterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AccountRouterScreen(),
      );
    },
    AccountRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AccountScreen(),
      );
    },
    AddressRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AddressScreen(),
      );
    },
    CartProductRoute.name: (routeData) {
      final args = routeData.argsAs<CartProductRouteArgs>(
          orElse: () => const CartProductRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CartProductScreen(
          key: args.key,
          isFromSearch: args.isFromSearch,
          incomingProduct: args.incomingProduct,
          incomingProductId: args.incomingProductId,
        ),
      );
    },
    CartRouterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CartRouterScreen(),
      );
    },
    CartRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CartScreen(),
      );
    },
    CategoriesRouterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CategoriesRouterScreen(),
      );
    },
    CategoriesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CategoriesScreen(),
      );
    },
    CategoryProductRoute.name: (routeData) {
      final args = routeData.argsAs<CategoryProductRouteArgs>(
          orElse: () => const CategoryProductRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CategoryProductScreen(
          key: args.key,
          isFromSearch: args.isFromSearch,
          incomingProduct: args.incomingProduct,
          incomingProductId: args.incomingProductId,
        ),
      );
    },
    CheckoutRoute.name: (routeData) {
      final args = routeData.argsAs<CheckoutRouteArgs>(
          orElse: () => const CheckoutRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CheckoutScreen(
          key: args.key,
          templateId: args.templateId,
        ),
      );
    },
    ClientByInnRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ClientByInnScreen(),
      );
    },
    ConfirmPaymentRoute.name: (routeData) {
      final args = routeData.argsAs<ConfirmPaymentRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ConfirmPaymentScreen(
          key: args.key,
          orderId: args.orderId,
        ),
      );
    },
    FavoritesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavoritesScreen(),
      );
    },
    HomeProductRoute.name: (routeData) {
      final args = routeData.argsAs<HomeProductRouteArgs>(
          orElse: () => const HomeProductRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HomeProductScreen(
          key: args.key,
          isFromSearch: args.isFromSearch,
          incomingProduct: args.incomingProduct,
          incomingProductId: args.incomingProductId,
        ),
      );
    },
    HomeRouterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeRouterScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginScreen(),
      );
    },
    NavBarRoute.name: (routeData) {
      final args = routeData.argsAs<NavBarRouteArgs>(
          orElse: () => const NavBarRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NavBarScreen(
          key: args.key,
          initialRoute: args.initialRoute,
        ),
      );
    },
    OrderDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<OrderDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OrderDetailsScreen(
          key: args.key,
          orderId: args.orderId,
        ),
      );
    },
    OrdersOrderRoute.name: (routeData) {
      final args = routeData.argsAs<OrdersOrderRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OrdersOrderScreen(
          key: args.key,
          orderId: args.orderId,
        ),
      );
    },
    OrdersProductRoute.name: (routeData) {
      final args = routeData.argsAs<OrdersProductRouteArgs>(
          orElse: () => const OrdersProductRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OrdersProductScreen(
          key: args.key,
          isFromSearch: args.isFromSearch,
          incomingProduct: args.incomingProduct,
          incomingProductId: args.incomingProductId,
        ),
      );
    },
    OrdersRouterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OrdersRouterScreen(),
      );
    },
    OrdersRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OrdersScreen(),
      );
    },
    ProductRoute.name: (routeData) {
      final args = routeData.argsAs<ProductRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProductScreen(
          key: args.key,
          incomingNavIndex: args.incomingNavIndex,
          incomingProduct: args.incomingProduct,
          isFromSearch: args.isFromSearch,
          incomingProductId: args.incomingProductId,
        ),
      );
    },
    ScannerRoute.name: (routeData) {
      final args = routeData.argsAs<ScannerRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ScannerScreen(
          key: args.key,
          order: args.order,
        ),
      );
    },
    SelectorRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SelectorScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsScreen(),
      );
    },
    SpecificProductsRoute.name: (routeData) {
      final args = routeData.argsAs<SpecificProductsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SpecificProductsScreen(
          key: args.key,
          category: args.category,
          subcategory: args.subcategory,
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
    TemplateRoute.name: (routeData) {
      final args = routeData.argsAs<TemplateRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TemplateScreen(
          key: args.key,
          template: args.template,
        ),
      );
    },
    UserInfoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UserInfoScreen(),
      );
    },
  };
}

/// generated route for
/// [AccountRouterScreen]
class AccountRouterRoute extends PageRouteInfo<void> {
  const AccountRouterRoute({List<PageRouteInfo>? children})
      : super(
          AccountRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountRouterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AccountScreen]
class AccountRoute extends PageRouteInfo<void> {
  const AccountRoute({List<PageRouteInfo>? children})
      : super(
          AccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AddressScreen]
class AddressRoute extends PageRouteInfo<void> {
  const AddressRoute({List<PageRouteInfo>? children})
      : super(
          AddressRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddressRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CartProductScreen]
class CartProductRoute extends PageRouteInfo<CartProductRouteArgs> {
  CartProductRoute({
    Key? key,
    bool isFromSearch = false,
    ProductDto? incomingProduct,
    int? incomingProductId,
    List<PageRouteInfo>? children,
  }) : super(
          CartProductRoute.name,
          args: CartProductRouteArgs(
            key: key,
            isFromSearch: isFromSearch,
            incomingProduct: incomingProduct,
            incomingProductId: incomingProductId,
          ),
          initialChildren: children,
        );

  static const String name = 'CartProductRoute';

  static const PageInfo<CartProductRouteArgs> page =
      PageInfo<CartProductRouteArgs>(name);
}

class CartProductRouteArgs {
  const CartProductRouteArgs({
    this.key,
    this.isFromSearch = false,
    this.incomingProduct,
    this.incomingProductId,
  });

  final Key? key;

  final bool isFromSearch;

  final ProductDto? incomingProduct;

  final int? incomingProductId;

  @override
  String toString() {
    return 'CartProductRouteArgs{key: $key, isFromSearch: $isFromSearch, incomingProduct: $incomingProduct, incomingProductId: $incomingProductId}';
  }
}

/// generated route for
/// [CartRouterScreen]
class CartRouterRoute extends PageRouteInfo<void> {
  const CartRouterRoute({List<PageRouteInfo>? children})
      : super(
          CartRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRouterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CartScreen]
class CartRoute extends PageRouteInfo<void> {
  const CartRoute({List<PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CategoriesRouterScreen]
class CategoriesRouterRoute extends PageRouteInfo<void> {
  const CategoriesRouterRoute({List<PageRouteInfo>? children})
      : super(
          CategoriesRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoriesRouterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CategoriesScreen]
class CategoriesRoute extends PageRouteInfo<void> {
  const CategoriesRoute({List<PageRouteInfo>? children})
      : super(
          CategoriesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoriesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CategoryProductScreen]
class CategoryProductRoute extends PageRouteInfo<CategoryProductRouteArgs> {
  CategoryProductRoute({
    Key? key,
    bool isFromSearch = false,
    ProductDto? incomingProduct,
    int? incomingProductId,
    List<PageRouteInfo>? children,
  }) : super(
          CategoryProductRoute.name,
          args: CategoryProductRouteArgs(
            key: key,
            isFromSearch: isFromSearch,
            incomingProduct: incomingProduct,
            incomingProductId: incomingProductId,
          ),
          initialChildren: children,
        );

  static const String name = 'CategoryProductRoute';

  static const PageInfo<CategoryProductRouteArgs> page =
      PageInfo<CategoryProductRouteArgs>(name);
}

class CategoryProductRouteArgs {
  const CategoryProductRouteArgs({
    this.key,
    this.isFromSearch = false,
    this.incomingProduct,
    this.incomingProductId,
  });

  final Key? key;

  final bool isFromSearch;

  final ProductDto? incomingProduct;

  final int? incomingProductId;

  @override
  String toString() {
    return 'CategoryProductRouteArgs{key: $key, isFromSearch: $isFromSearch, incomingProduct: $incomingProduct, incomingProductId: $incomingProductId}';
  }
}

/// generated route for
/// [CheckoutScreen]
class CheckoutRoute extends PageRouteInfo<CheckoutRouteArgs> {
  CheckoutRoute({
    Key? key,
    String? templateId,
    List<PageRouteInfo>? children,
  }) : super(
          CheckoutRoute.name,
          args: CheckoutRouteArgs(
            key: key,
            templateId: templateId,
          ),
          initialChildren: children,
        );

  static const String name = 'CheckoutRoute';

  static const PageInfo<CheckoutRouteArgs> page =
      PageInfo<CheckoutRouteArgs>(name);
}

class CheckoutRouteArgs {
  const CheckoutRouteArgs({
    this.key,
    this.templateId,
  });

  final Key? key;

  final String? templateId;

  @override
  String toString() {
    return 'CheckoutRouteArgs{key: $key, templateId: $templateId}';
  }
}

/// generated route for
/// [ClientByInnScreen]
class ClientByInnRoute extends PageRouteInfo<void> {
  const ClientByInnRoute({List<PageRouteInfo>? children})
      : super(
          ClientByInnRoute.name,
          initialChildren: children,
        );

  static const String name = 'ClientByInnRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ConfirmPaymentScreen]
class ConfirmPaymentRoute extends PageRouteInfo<ConfirmPaymentRouteArgs> {
  ConfirmPaymentRoute({
    Key? key,
    required int orderId,
    List<PageRouteInfo>? children,
  }) : super(
          ConfirmPaymentRoute.name,
          args: ConfirmPaymentRouteArgs(
            key: key,
            orderId: orderId,
          ),
          initialChildren: children,
        );

  static const String name = 'ConfirmPaymentRoute';

  static const PageInfo<ConfirmPaymentRouteArgs> page =
      PageInfo<ConfirmPaymentRouteArgs>(name);
}

class ConfirmPaymentRouteArgs {
  const ConfirmPaymentRouteArgs({
    this.key,
    required this.orderId,
  });

  final Key? key;

  final int orderId;

  @override
  String toString() {
    return 'ConfirmPaymentRouteArgs{key: $key, orderId: $orderId}';
  }
}

/// generated route for
/// [FavoritesScreen]
class FavoritesRoute extends PageRouteInfo<void> {
  const FavoritesRoute({List<PageRouteInfo>? children})
      : super(
          FavoritesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoritesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeProductScreen]
class HomeProductRoute extends PageRouteInfo<HomeProductRouteArgs> {
  HomeProductRoute({
    Key? key,
    bool isFromSearch = false,
    ProductDto? incomingProduct,
    int? incomingProductId,
    List<PageRouteInfo>? children,
  }) : super(
          HomeProductRoute.name,
          args: HomeProductRouteArgs(
            key: key,
            isFromSearch: isFromSearch,
            incomingProduct: incomingProduct,
            incomingProductId: incomingProductId,
          ),
          initialChildren: children,
        );

  static const String name = 'HomeProductRoute';

  static const PageInfo<HomeProductRouteArgs> page =
      PageInfo<HomeProductRouteArgs>(name);
}

class HomeProductRouteArgs {
  const HomeProductRouteArgs({
    this.key,
    this.isFromSearch = false,
    this.incomingProduct,
    this.incomingProductId,
  });

  final Key? key;

  final bool isFromSearch;

  final ProductDto? incomingProduct;

  final int? incomingProductId;

  @override
  String toString() {
    return 'HomeProductRouteArgs{key: $key, isFromSearch: $isFromSearch, incomingProduct: $incomingProduct, incomingProductId: $incomingProductId}';
  }
}

/// generated route for
/// [HomeRouterScreen]
class HomeRouterRoute extends PageRouteInfo<void> {
  const HomeRouterRoute({List<PageRouteInfo>? children})
      : super(
          HomeRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRouterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NavBarScreen]
class NavBarRoute extends PageRouteInfo<NavBarRouteArgs> {
  NavBarRoute({
    Key? key,
    String? initialRoute,
    List<PageRouteInfo>? children,
  }) : super(
          NavBarRoute.name,
          args: NavBarRouteArgs(
            key: key,
            initialRoute: initialRoute,
          ),
          initialChildren: children,
        );

  static const String name = 'NavBarRoute';

  static const PageInfo<NavBarRouteArgs> page = PageInfo<NavBarRouteArgs>(name);
}

class NavBarRouteArgs {
  const NavBarRouteArgs({
    this.key,
    this.initialRoute,
  });

  final Key? key;

  final String? initialRoute;

  @override
  String toString() {
    return 'NavBarRouteArgs{key: $key, initialRoute: $initialRoute}';
  }
}

/// generated route for
/// [OrderDetailsScreen]
class OrderDetailsRoute extends PageRouteInfo<OrderDetailsRouteArgs> {
  OrderDetailsRoute({
    Key? key,
    required int orderId,
    List<PageRouteInfo>? children,
  }) : super(
          OrderDetailsRoute.name,
          args: OrderDetailsRouteArgs(
            key: key,
            orderId: orderId,
          ),
          initialChildren: children,
        );

  static const String name = 'OrderDetailsRoute';

  static const PageInfo<OrderDetailsRouteArgs> page =
      PageInfo<OrderDetailsRouteArgs>(name);
}

class OrderDetailsRouteArgs {
  const OrderDetailsRouteArgs({
    this.key,
    required this.orderId,
  });

  final Key? key;

  final int orderId;

  @override
  String toString() {
    return 'OrderDetailsRouteArgs{key: $key, orderId: $orderId}';
  }
}

/// generated route for
/// [OrdersOrderScreen]
class OrdersOrderRoute extends PageRouteInfo<OrdersOrderRouteArgs> {
  OrdersOrderRoute({
    Key? key,
    required int orderId,
    List<PageRouteInfo>? children,
  }) : super(
          OrdersOrderRoute.name,
          args: OrdersOrderRouteArgs(
            key: key,
            orderId: orderId,
          ),
          initialChildren: children,
        );

  static const String name = 'OrdersOrderRoute';

  static const PageInfo<OrdersOrderRouteArgs> page =
      PageInfo<OrdersOrderRouteArgs>(name);
}

class OrdersOrderRouteArgs {
  const OrdersOrderRouteArgs({
    this.key,
    required this.orderId,
  });

  final Key? key;

  final int orderId;

  @override
  String toString() {
    return 'OrdersOrderRouteArgs{key: $key, orderId: $orderId}';
  }
}

/// generated route for
/// [OrdersProductScreen]
class OrdersProductRoute extends PageRouteInfo<OrdersProductRouteArgs> {
  OrdersProductRoute({
    Key? key,
    bool isFromSearch = false,
    ProductDto? incomingProduct,
    int? incomingProductId,
    List<PageRouteInfo>? children,
  }) : super(
          OrdersProductRoute.name,
          args: OrdersProductRouteArgs(
            key: key,
            isFromSearch: isFromSearch,
            incomingProduct: incomingProduct,
            incomingProductId: incomingProductId,
          ),
          initialChildren: children,
        );

  static const String name = 'OrdersProductRoute';

  static const PageInfo<OrdersProductRouteArgs> page =
      PageInfo<OrdersProductRouteArgs>(name);
}

class OrdersProductRouteArgs {
  const OrdersProductRouteArgs({
    this.key,
    this.isFromSearch = false,
    this.incomingProduct,
    this.incomingProductId,
  });

  final Key? key;

  final bool isFromSearch;

  final ProductDto? incomingProduct;

  final int? incomingProductId;

  @override
  String toString() {
    return 'OrdersProductRouteArgs{key: $key, isFromSearch: $isFromSearch, incomingProduct: $incomingProduct, incomingProductId: $incomingProductId}';
  }
}

/// generated route for
/// [OrdersRouterScreen]
class OrdersRouterRoute extends PageRouteInfo<void> {
  const OrdersRouterRoute({List<PageRouteInfo>? children})
      : super(
          OrdersRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrdersRouterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OrdersScreen]
class OrdersRoute extends PageRouteInfo<void> {
  const OrdersRoute({List<PageRouteInfo>? children})
      : super(
          OrdersRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrdersRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProductScreen]
class ProductRoute extends PageRouteInfo<ProductRouteArgs> {
  ProductRoute({
    Key? key,
    required int incomingNavIndex,
    ProductDto? incomingProduct,
    bool isFromSearch = false,
    int? incomingProductId,
    List<PageRouteInfo>? children,
  }) : super(
          ProductRoute.name,
          args: ProductRouteArgs(
            key: key,
            incomingNavIndex: incomingNavIndex,
            incomingProduct: incomingProduct,
            isFromSearch: isFromSearch,
            incomingProductId: incomingProductId,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductRoute';

  static const PageInfo<ProductRouteArgs> page =
      PageInfo<ProductRouteArgs>(name);
}

class ProductRouteArgs {
  const ProductRouteArgs({
    this.key,
    required this.incomingNavIndex,
    this.incomingProduct,
    this.isFromSearch = false,
    this.incomingProductId,
  });

  final Key? key;

  final int incomingNavIndex;

  final ProductDto? incomingProduct;

  final bool isFromSearch;

  final int? incomingProductId;

  @override
  String toString() {
    return 'ProductRouteArgs{key: $key, incomingNavIndex: $incomingNavIndex, incomingProduct: $incomingProduct, isFromSearch: $isFromSearch, incomingProductId: $incomingProductId}';
  }
}

/// generated route for
/// [ScannerScreen]
class ScannerRoute extends PageRouteInfo<ScannerRouteArgs> {
  ScannerRoute({
    Key? key,
    required OrderDetailsDto order,
    List<PageRouteInfo>? children,
  }) : super(
          ScannerRoute.name,
          args: ScannerRouteArgs(
            key: key,
            order: order,
          ),
          initialChildren: children,
        );

  static const String name = 'ScannerRoute';

  static const PageInfo<ScannerRouteArgs> page =
      PageInfo<ScannerRouteArgs>(name);
}

class ScannerRouteArgs {
  const ScannerRouteArgs({
    this.key,
    required this.order,
  });

  final Key? key;

  final OrderDetailsDto order;

  @override
  String toString() {
    return 'ScannerRouteArgs{key: $key, order: $order}';
  }
}

/// generated route for
/// [SelectorScreen]
class SelectorRoute extends PageRouteInfo<void> {
  const SelectorRoute({List<PageRouteInfo>? children})
      : super(
          SelectorRoute.name,
          initialChildren: children,
        );

  static const String name = 'SelectorRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SpecificProductsScreen]
class SpecificProductsRoute extends PageRouteInfo<SpecificProductsRouteArgs> {
  SpecificProductsRoute({
    Key? key,
    required CategoriesDto category,
    required CategoriesDto subcategory,
    List<PageRouteInfo>? children,
  }) : super(
          SpecificProductsRoute.name,
          args: SpecificProductsRouteArgs(
            key: key,
            category: category,
            subcategory: subcategory,
          ),
          initialChildren: children,
        );

  static const String name = 'SpecificProductsRoute';

  static const PageInfo<SpecificProductsRouteArgs> page =
      PageInfo<SpecificProductsRouteArgs>(name);
}

class SpecificProductsRouteArgs {
  const SpecificProductsRouteArgs({
    this.key,
    required this.category,
    required this.subcategory,
  });

  final Key? key;

  final CategoriesDto category;

  final CategoriesDto subcategory;

  @override
  String toString() {
    return 'SpecificProductsRouteArgs{key: $key, category: $category, subcategory: $subcategory}';
  }
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TemplateScreen]
class TemplateRoute extends PageRouteInfo<TemplateRouteArgs> {
  TemplateRoute({
    Key? key,
    required TemplateResponse template,
    List<PageRouteInfo>? children,
  }) : super(
          TemplateRoute.name,
          args: TemplateRouteArgs(
            key: key,
            template: template,
          ),
          initialChildren: children,
        );

  static const String name = 'TemplateRoute';

  static const PageInfo<TemplateRouteArgs> page =
      PageInfo<TemplateRouteArgs>(name);
}

class TemplateRouteArgs {
  const TemplateRouteArgs({
    this.key,
    required this.template,
  });

  final Key? key;

  final TemplateResponse template;

  @override
  String toString() {
    return 'TemplateRouteArgs{key: $key, template: $template}';
  }
}

/// generated route for
/// [UserInfoScreen]
class UserInfoRoute extends PageRouteInfo<void> {
  const UserInfoRoute({List<PageRouteInfo>? children})
      : super(
          UserInfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserInfoRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
