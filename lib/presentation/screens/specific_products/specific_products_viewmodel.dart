import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/data/models/categories/catigories_dto.dart';
import 'package:flutter/material.dart';
import 'package:bingo/data/models/products/response/product_model.dart';
import 'package:bingo/domain/services/products_service/products_service.dart';
import 'package:stacked/stacked.dart';
import '../../../data/models/products/response/cart_model.dart';

class SpecificProductsViewModel extends ReactiveViewModel {
  final ProductsService _productsService = getIt();
  CartDto? get cartData => _productsService.cartData;
  @override
  List<ListenableServiceMixin> get listenableServices => [_productsService];

  ProductsPagination? get products => _productsService.specificProducts;
  List<TextEditingController> quantityController = [];
  List<FocusNode> quantityFocus = [];

  bool isType = true;
  bool loadmore = false;
  bool getProduct =false;

  ScrollController scrollController = ScrollController();

  onReady(CategoriesDto subCategory) {
    getProducts(subCategory.id!);
    scrollController.addListener(() {
      if (scrollController.position.extentAfter < 100 &&
          !isBusy &&
          products?.next != null) {
            onLoadMore();
          }
    });
  }

  getProducts(int id) async {
    getProduct = true;
    setBusy(true);
    try {
      await _productsService.fetchProductsBySub(id);
      quantityFocus.addAll(List.generate(20, (index) => FocusNode()));
    quantityController.addAll(List.generate(20, (index) => TextEditingController()));


    } catch (e) {
      print(e);
    }
    getProduct = false;
    setBusy(false);
  }

  productType() async {
    isType =!isType;
    rebuildUi();
  }

  onProductTapped({ProductDto? product, int? productId}) async {
    router.navigate(CategoryProductRoute(
        incomingProduct: product, incomingProductId: productId));
  }

  onAddToCart(ProductDto product, {int? index}) async {
    try {
      product.isBusy = true;
      notifyListeners();
      await _productsService.addToCart(
          product.id!,
          quantityController[index ?? 0].text == ''
              ? 1
              : int.parse(quantityController[index ?? 0].text));
      product.inCart = true;
    } catch (e) {
      print(e);
    }
    product.isBusy = false;
    notifyListeners();
  }

  delFromCart(ProductDto product) async {
    try {
      product.isBusy = true;
      notifyListeners();

      await _productsService.delFromCart([product.id!]);
      product.inCart = false;
    } catch (e) {
      print(e);
    }
    product.isBusy = false;
    notifyListeners();
  }

  onChangeCount(String values, int index, {bool? isIncrement}) async {
    int? value = double.tryParse(quantityController[index].text)?.toInt();
    if (value != null) {
      try {
        // await changeCounInCart(index);
      } catch (e) {
        return;
      }
    }
    if (isIncrement != null && value != null) {
      isIncrement
          ? value++
          : value == 1
          ? null
          : value--;
    }
    if (values.isEmpty && value != null) {
      quantityController[index].text = value.toString();
      for (var element in quantityFocus) {
        element?.unfocus();
      }
    }
    notifyListeners();
  }

  Future<void> changeCounInCart(int index) async {
    try {
      await _productsService.updateCartProduct(
          cartData!.cartproducts![index].product!.id!,
          int.parse(quantityController[index].text));
    } catch (e) {
      print(e);
    }
  }

  back() {
    router.back();
  }

  onLoadMore() async {
    loadmore = true;
    setBusy(true);
    try {
      final res = await _productsService.loadMoreSpecificProducts();

      quantityFocus.addAll(List.generate(res, (index) => FocusNode()));
      quantityController.addAll(List.generate(res, (index) => TextEditingController()));

      rebuildUi();
    } catch (e) {
      print(e);
    }
    loadmore = false;
    setBusy(false);
  }

  void rebuild() {
    rebuildUi();
  }
}
