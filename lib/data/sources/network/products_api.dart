import 'package:bingo/app/locator.dart';
import 'package:bingo/core/network/constants.dart';
import 'package:bingo/core/network/globuskans_api_service.dart';
import 'package:bingo/data/models/products/request/add_cart_request.dart';
import 'package:bingo/data/models/products/response/cart_model.dart';
import 'package:bingo/data/models/products/response/favorites_model.dart';
import 'package:bingo/data/models/products/response/posters_model.dart';
import 'package:bingo/data/models/products/response/product_model.dart';
import 'package:bingo/data/models/search/search_request.dart';

import '../../models/pagination/request.dart';

abstract class ProductsApi {
  Future<ProductsPagination> fetchProductsOfDay();

  Future<ProductsPagination> fetchRecs({String? url});

  Future<ProductsPagination> fetchLastViewed();

  Future<ProductsPagination> fetchLatest();

  Future<ProductsPagination> fetchPopular(PaginationRequest request, {String? url});

  Future<ProductsPagination> fetchByPagination(String url);

  Future<ProductDto> fetchProductById(int id);

  Future<CartDto> getCartProducts(int? inn);

  Future addToCart(int? inn ,AddCartRequest request);

  Future delFromCart(int? inn ,AddCartRequest request);

  Future updateCartProduct(AddCartRequest request);

  Future addToFav(AddCartRequest request);

  Future delFromFav(AddCartRequest request);

  Future<List<PostersDto>> fetchPosters();

  Future<List<FavoriteDto>> fetchFavorites();

  Future<ProductsPagination> fetchProductsBySub(int subId,PaginationRequest request, {String? url});
}

class ProductsApiImpl extends ProductsApi {
  final BingoApi _bingoApi = getIt();

  @override
  Future<ProductsPagination> fetchProductsOfDay() async {
    try {
      final res = await _bingoApi.get(NetworkConstants.hitProducts);

      final ProductsPagination myList = ProductsPagination.fromJson(res);

      return myList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductDto> fetchProductById(int id) async {
    try {
      final res = await _bingoApi.get('${NetworkConstants.products}$id/');

      final ProductDto productRes = ProductDto.fromJson(res);

      return productRes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CartDto> getCartProducts(int? inn) async {
    try {
      final res = await _bingoApi.get("${NetworkConstants.cart}$inn");
      return CartDto.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future addToCart(int? inn ,AddCartRequest request) async {
    try {
      await _bingoApi.post("${NetworkConstants.cart}$inn/", data: request.toJson());
    } catch (e) {
      rethrow;
    }
  }


  @override
  Future delFromCart(int? inn ,AddCartRequest request) async {
    try {
      await _bingoApi.delete("${NetworkConstants.cart}$inn/", data: request.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future updateCartProduct(AddCartRequest request) async {
    try {
      await _bingoApi.patch(NetworkConstants.cart, data: request.toJson());
    } catch (e) {
      rethrow;
    }
  }


  @override
  Future addToFav(AddCartRequest request) async {
    try {
      await _bingoApi.post(NetworkConstants.addFavorite,
          data: request.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future delFromFav(AddCartRequest request) async {
    try {
      await _bingoApi.delete(NetworkConstants.addFavorite,
          data: request.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PostersDto>> fetchPosters() async {
    try {
      final res = await _bingoApi.get(NetworkConstants.posters);
      return List.from(res).map((e) => PostersDto.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<FavoriteDto>> fetchFavorites() async {
    try {
      final res = await _bingoApi.get(NetworkConstants.fetchFavorites);

      return List.from(res).map((e) => FavoriteDto.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductsPagination> fetchRecs({String? url}) async {
    try {
      final res =
          await _bingoApi.get(url ?? NetworkConstants.recomendedProducts);

      final ProductsPagination myList = ProductsPagination.fromJson(res);
      return myList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductsPagination> fetchLastViewed() async {
    try {
      final res = await _bingoApi.get(NetworkConstants.lastViewedProducts);

      final ProductsPagination myList = ProductsPagination.fromJson(res);
      return myList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductsPagination> fetchPopular(PaginationRequest request, {String? url}) async {
    try {
      final res = await _bingoApi.get(url ?? "${NetworkConstants.popularProducts}?page=${request.page}&page_size=${request.pageSize}");

      final ProductsPagination myList = ProductsPagination.fromJson(res);
      return myList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductsPagination> fetchLatest({SearchRequest? request}) async {
    try {
      final res =
          await _bingoApi.get(request?.url ?? NetworkConstants.latestProducts);

      final ProductsPagination myList = ProductsPagination.fromJson(res);
      return myList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductsPagination> fetchByPagination(String url) async {
    try {
      final res = await _bingoApi.get(url);

      final ProductsPagination myList = ProductsPagination.fromJson(res);

      return myList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductsPagination> fetchProductsBySub(int subId,PaginationRequest request, {String? url}) async {
    try {
      final res = await _bingoApi.get(url ??
          "${"${NetworkConstants.baseApiUrl}$subId/subcategories/products"}?page=${request.page}&page_size=${request.pageSize}");

      final ProductsPagination myList = ProductsPagination.fromJson(res);

      return myList;
    } catch (e) {
      rethrow;
    }
  }
}
