import 'package:bingo/app/locator.dart';
import 'package:bingo/core/enum/user_status.dart';
import 'package:bingo/data/models/products/response/cart_model.dart';
import 'package:bingo/domain/services/auth_service/auth_service.dart';
import 'package:bingo/domain/services/navbar_service/navbar_service.dart';
import 'package:bingo/domain/services/products_service/products_service.dart';
import 'package:bingo/presentation/screens/nav_bar/widgets/bottom_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';

class NavBarViewModel extends ReactiveViewModel {
  final NavBarService _navBarService = getIt();
  final AuthService _authService = getIt();
  final ProductsService _productsService = getIt();

  int get currIndex => _navBarService.currIndex;
  UserStatus get userStatus => _authService.userStatus;
  CartDto? get cartData => _productsService.cartData;

  List<NavBarItem> navBarItems = [
    // NavBarItem(icon: IconlyLight.home, activeIcon: IconlyBold.home),
    NavBarItem(icon: IconlyLight.category, activeIcon: IconlyBold.category),
    NavBarItem(icon: IconlyLight.buy, activeIcon: IconlyBold.buy),
    NavBarItem(icon: IconlyLight.bag_2, activeIcon: IconlyBold.bag_2),
    // NavBarItem(icon: IconlyLight.profile, activeIcon: IconlyBold.profile)
  ];

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_navBarService, _authService, _productsService];

  onReady() async {

  }

  countProductsInCart() {
    int count = 0;
    if (cartData != null) {
      for (final cartProduct in cartData!.cartproducts!) {
        count += cartProduct.quantity!;
      }
    }
    return count;
  }
}
