// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:bingo/app/locator.dart';
import 'package:bingo/data/models/products/request/add_cart_request.dart';
import 'package:bingo/data/models/products/response/cart_model.dart';
import 'package:bingo/data/models/products/response/favorites_model.dart';
import 'package:bingo/data/models/products/response/posters_model.dart';
import 'package:bingo/data/models/products/response/product_model.dart';
import 'package:bingo/domain/repositories/products_repository.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:collection/collection.dart';
import '../../../data/models/pagination/request.dart';

class ProductsService with ListenableServiceMixin {
  final ProductsRepository _productsRepository =
      getIt<ProductsRepositoryImpl>();

  ProductsService() {
    listenToReactiveValues([
      _popularProducts,
      _latestProducts,
      _lastViewedProducts,
      _cartData,
      _postersList,
      _productsQuantity,
      _quantityFocus,
      _favorites
    ]);
  }


  final ReactiveValue<ProductsPagination?> _popularProducts =
      ReactiveValue(null);
  final ReactiveValue<ProductsPagination?> _latestProducts =
      ReactiveValue(null);
  final ReactiveValue<ProductsPagination?> _lastViewedProducts =
      ReactiveValue(null);
  final ReactiveValue<ProductsPagination?> _specificProducts =
      ReactiveValue(null);
  final ReactiveValue<CartDto?> _cartData = ReactiveValue(null);
  final ReactiveValue<List<TextEditingController>> _productsQuantity =
      ReactiveValue([]);
  final ReactiveValue<List<FocusNode>> _quantityFocus = ReactiveValue([]);
  final ReactiveList<PostersDto> _postersList = ReactiveList();
  final ReactiveValue<List<FavoriteDto>?> _favorites = ReactiveValue(null);

  final ReactiveValue<ProductDto?> _product = ReactiveValue(null);

  ProductDto? get product => _product.value;

  final ReactiveValue<bool?> _productIn = ReactiveValue(null);

  bool? get productIn => _productIn.value;

  ProductsPagination? get popularProducts => _popularProducts.value;
  ProductsPagination? get latestProducts => _latestProducts.value;
  ProductsPagination? get lastViewedProducts => _lastViewedProducts.value;
  ProductsPagination? get specificProducts => _specificProducts.value;
  CartDto? get cartData => _cartData.value;
  List<TextEditingController> get productsQuantity => _productsQuantity.value;
  List<FocusNode> get quantityFocus => _quantityFocus.value;
  List<PostersDto> get postersList => _postersList;
  List<FavoriteDto>? get favorites => _favorites.value;

  StreamController<double> controller = StreamController<double>();
  Stream? stream;

  // Future<void> fetchProductsOfDay() async {
  //   try {
  //     final res = await _productsRepository.fetchProductsOfDay();
  //     _productsOfDay.value = res;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<int> fetchPopular({String? url}) async {
    try {
      final res = await _productsRepository.fetchPopular(PaginationRequest(),url: url);
      if (url != null) {
        popularProducts?.next = res.next;
        popularProducts?.results?.addAll(res.results!);

      } else {
        _popularProducts.value = res;
      }
      return res.results!.length;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchLastViewed() async {
    try {
      final res = await _productsRepository.fetchLastViewed();
      _lastViewedProducts.value = res;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchLatest() async {
    try {
      final res = await _productsRepository.fetchLatest();
      _latestProducts.value = res;
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> fetchRecs({String? url}) async {
  //   try {
  //     final res = await _productsRepository.fetchRecs(url: url);
  //     if (url != null) {
  //       _popularProducts.value?.next = res.next;
  //       _popularProducts.value?.singleResults?.addAll(res.singleResults!);
  //     } else {
  //       _popularProducts.value = res;
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<ProductDto> fetchProductById(int id) async {
    try {
      final res = await _productsRepository.fetchProductById(id);
      stream = controller.stream;

      _product.value = res;
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getCartProduct() async {
    try {
      final res = await _productsRepository.getCartProducts();
      // if (stream != null) {
      //   controller.add(1);
      // }

      _cartData.value = res;
      List<TextEditingController> allQuantityCounter = [];
      List<FocusNode> allFocusNodes = [];
      for (var product in cartData!.cartproducts!) {
        allQuantityCounter
            .add(TextEditingController(text: product.quantity.toString()));
        allFocusNodes.add(FocusNode());
      }
      _productsQuantity.value = allQuantityCounter;
      _quantityFocus.value = allFocusNodes;
    } catch (e) {
     print(e);
    }
  }

  Future<void> addToCart(int productId, int quantity) async {
    AddCartRequest request =
        AddCartRequest(productId: productId, quantity: quantity);
    try {
      await _productsRepository.addToCart(request);

      if (popularProducts != null) {
        popularProducts!.results!
            .firstWhereOrNull((element) => element.id == productId)
            ?.inCart = true;
      }

      if (specificProducts != null) {
        specificProducts!.results!
            .firstWhereOrNull((element) => element.id == productId)
            ?.inCart = true;
      }

      if (lastViewedProducts != null) {
        lastViewedProducts!.results!
            .firstWhereOrNull((element) => element.id == productId)
            ?.inCart = true;
      }

      if ( product?.id == productId) {

        product!.inCart = true;
      }

      await getCartProduct();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addToFav(int productId) async {
    AddCartRequest request = AddCartRequest(productId: productId);
    try {
      await _productsRepository.addToFav(request);
      // if (productsOfDay != null) {
      //   productsOfDay!.results!
      //       .firstWhereOrNull((element) => element.id == productId)
      //       ?.infav = true;
      // }
      fetchFavorites();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delFromFav(int productId) async {
    AddCartRequest request = AddCartRequest(productId: productId);
    try {
      await _productsRepository.delFromFav(request);
      fetchFavorites();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delFromCart(List<int> ids) async {
    try {
      AddCartRequest request = AddCartRequest(cartProductsIds: ids);
      await _productsRepository.delFromCart(request);
      for (var id in ids) {
        if (popularProducts != null) {
          popularProducts!.results!
              .firstWhereOrNull((element) => element.id == id)
              ?.inCart = false;
        }
      }

      for (var id in ids) {
        if (specificProducts != null) {
          specificProducts!.results!
              .firstWhereOrNull((element) => element.id == id)
              ?.inCart = false;
        }
      }

      for (var id in ids) {
        if (lastViewedProducts != null) {
          lastViewedProducts!.results!
              .firstWhereOrNull((element) => element.id == id)
              ?.inCart = false;
        }
      }

      for (var id in ids) {
        if ( product?.id == id) {
          product!.inCart = false;
        }
      }


      await getCartProduct();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateCartProduct(int id, int quantity) async {
    AddCartRequest request = AddCartRequest(productId: id, quantity: quantity);
    try {
      await _productsRepository.updateCartProduct(request);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchPosters() async {
    try {
      final res = await _productsRepository.fetchPosters();
      _postersList.addAll(res);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchFavorites() async {
    try {
      final res = await _productsRepository.fetchFavorites();
      _favorites.value = res;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductsPagination> fetchByPagination(String url) async {
    try {
      return _productsRepository.fetchByPagination(url);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchProductsBySub(int subId,{String? url}) async {
    try {
      final res = await _productsRepository.fetchProductsBySub(subId,PaginationRequest(),url: url);
      print(res.results?.length);
      subId == 0 ? _specificProducts.value = null : _specificProducts.value =
          res;
      _specificProducts.value?.next = res.next;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> loadMoreSpecificProducts() async {
    try {
      final res = await fetchByPagination(specificProducts!.next!);
      specificProducts!.next = res.next;
      if (res.results != null) {
        specificProducts?.results?.addAll(res.results!);
      }
      if (res.singleResults != null) {
        specificProducts?.singleResults?.addAll(res.singleResults!);
      }
      return res.results?.length ?? res.singleResults!.length;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> loadMorePopularProducts() async {
    try {
      final res = await fetchByPagination(popularProducts!.next!);
      popularProducts!.next = res.next;
      if (res.results != null) {
        popularProducts?.results?.addAll(res.results!);
      }
      if (res.singleResults != null) {
        popularProducts?.singleResults?.addAll(res.singleResults!);
      }
      return res.results?.length ?? res.singleResults!.length;
    } catch (e) {
      rethrow;
    }
  }
}
