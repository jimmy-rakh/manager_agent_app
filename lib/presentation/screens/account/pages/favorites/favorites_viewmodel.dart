
import 'package:bingo/app/locator.dart';
import 'package:bingo/data/models/products/response/favorites_model.dart';
import 'package:bingo/data/models/products/response/product_model.dart';
import 'package:bingo/domain/services/navigation_service/navigation_service.dart';
import 'package:bingo/domain/services/products_service/products_service.dart';
import 'package:stacked/stacked.dart';

class FavoritesViewModel extends ReactiveViewModel {
  final ProductsService _productsService = getIt();
  @override
  List<ListenableServiceMixin> get listenableServices => [_productsService];

  List<FavoriteDto>? get favorites => _productsService.favorites;

  onReady() {
    getData();
  }

  getData() async {
    try {
      await _productsService.fetchFavorites();
    } catch (e) {
      NavigationService.showErrorToast(e.toString());
    }
  }

  delFromFavorites(int id) async {
    try {
      await _productsService.delFromFav(id);
    } catch (e) {
      NavigationService.showErrorToast(e.toString());
    }
  }

  onProductTapped(ProductDto product) async {
    // TODO await NavigationService.pushNamed(
    //   routeName: NestedScreenRoutes.productPage,
    //   navIndex: 4,
    //   arguments:
    //       ProductPageArguments(incomingNavIndex: 4, incomingProduct: product),
    // );
  }
}
