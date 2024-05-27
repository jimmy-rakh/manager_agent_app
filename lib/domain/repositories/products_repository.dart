import 'package:bingo/app/locator.dart';
import 'package:bingo/data/models/products/request/add_cart_request.dart';
import 'package:bingo/data/models/products/response/cart_model.dart';
import 'package:bingo/data/models/products/response/favorites_model.dart';
import 'package:bingo/data/models/products/response/posters_model.dart';
import 'package:bingo/data/models/products/response/product_model.dart';
import 'package:bingo/data/models/search/search_request.dart';
import 'package:bingo/data/sources/network/products_api.dart';

import '../../data/models/pagination/request.dart';

abstract class ProductsRepository {
  Future<ProductsPagination> fetchProductsOfDay();
  Future<ProductsPagination> fetchRecs({String? url});
  Future<ProductsPagination> fetchLastViewed();
  Future<ProductsPagination> fetchLatest();
  Future<ProductsPagination> fetchPopular(PaginationRequest request, {String? url});
  Future<ProductsPagination> fetchByPagination(String url);
  Future<ProductDto> fetchProductById(int id);
  Future<CartDto> getCartProducts(int? inn);
  Future addToCart(int? inn,AddCartRequest request);
  Future delFromCart(int? inn,AddCartRequest request);
  Future addToFav(AddCartRequest request);
  Future delFromFav(AddCartRequest request);
  Future updateCartProduct(AddCartRequest request);
  Future<List<PostersDto>> fetchPosters();
  Future<List<FavoriteDto>> fetchFavorites({SearchRequest? request});
  Future<ProductsPagination> fetchProductsBySub(int subId,PaginationRequest request, {String? url});
}

class ProductsRepositoryImpl extends ProductsRepository {
  final _api = getIt<ProductsApiImpl>();

  @override
  Future<ProductsPagination> fetchProductsOfDay(
      {SearchRequest? request}) async {
    try {
      return _api.fetchProductsOfDay();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductDto> fetchProductById(int id) {
    try {
      return _api.fetchProductById(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CartDto> getCartProducts(int? inn) async {
    try {
      return await _api.getCartProducts(inn);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future addToCart(int? inn,AddCartRequest request) async {
    try {
      await _api.addToCart(inn,request);
    } catch (e) {
      rethrow;
    }
  }


  @override
  Future delFromCart(int? inn,AddCartRequest request) async {
    try {
      await _api.delFromCart(inn,request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future updateCartProduct(AddCartRequest request) async {
    try {
      await _api.updateCartProduct(request);
    } catch (e) {
      rethrow;
    }
  }
  @override
  Future addToFav(AddCartRequest request) async {
    try {
      await _api.addToFav(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future delFromFav(AddCartRequest request) async {
    try {
      await _api.delFromFav(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PostersDto>> fetchPosters() async {
    try {
      return await _api.fetchPosters();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<FavoriteDto>> fetchFavorites({SearchRequest? request}) async {
    try {
      return await _api.fetchFavorites();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductsPagination> fetchLastViewed({SearchRequest? request}) async {
    try {
      return await _api.fetchLastViewed();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductsPagination> fetchLatest({SearchRequest? request}) async {
    try {
      return await _api.fetchLatest();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductsPagination> fetchPopular(PaginationRequest request, {String? url}) async {
    try {
      return await _api.fetchPopular(request,url: url);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductsPagination> fetchRecs({String? url}) async {
    try {
      return await _api.fetchRecs(url: url);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductsPagination> fetchByPagination(String url) async {
    try {
      return await _api.fetchByPagination(url);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductsPagination> fetchProductsBySub(int subId,PaginationRequest request, {String? url}) async {
    try {
      return await _api.fetchProductsBySub(subId,request,url:url);
    } catch (e) {
      rethrow;
    }
  }
}
