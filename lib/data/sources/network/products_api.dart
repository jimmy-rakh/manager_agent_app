import 'package:bingo/app/locator.dart';
import 'package:bingo/core/network/constants.dart';
import 'package:bingo/core/network/globuskans_api_service.dart';
import 'package:bingo/data/models/products/request/add_cart_request.dart';
import 'package:bingo/data/models/products/response/cart_model.dart';
import 'package:bingo/data/models/products/response/product_model.dart';
import '../../models/pagination/request.dart';

abstract class ProductsApi {

  Future<ProductsPagination> fetchByPagination(String url);

  Future<ProductDto> fetchProductById(int id);

  Future<CartDto> getCartProducts(int? inn);

  Future addToCart(int? inn ,AddCartRequest request);

  Future delFromCart(int? inn ,AddCartRequest request);

  Future updateCartProduct(AddCartRequest request);

  Future<ProductsPagination> fetchProductsBySub(int subId,PaginationRequest request, {String? url});
}

class ProductsApiImpl extends ProductsApi {
  final BingoApi _bingoApi = getIt();

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
