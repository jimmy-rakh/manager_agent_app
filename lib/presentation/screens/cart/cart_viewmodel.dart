import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/core/enum/user_status.dart';
import 'package:bingo/data/models/products/response/cart_model.dart';
import 'package:bingo/data/models/products/response/product_model.dart';
import 'package:bingo/domain/services/auth_service/auth_service.dart';
import 'package:bingo/domain/services/navigation_service/navigation_service.dart';
import 'package:bingo/domain/services/products_service/products_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:stacked/stacked.dart';

class CartViewModel extends ReactiveViewModel {
  final ProductsService _productsService = getIt();
  final AuthService _authService = getIt();

  @override
  List<ListenableServiceMixin> get listenableServices => [_productsService];

  CartDto? get cartData => _productsService.cartData;

  List<TextEditingController> get productsQuantity =>
      _productsService.productsQuantity;

  UserStatus get userStatus => _authService.userStatus;

  List<FocusNode> get quantityFocus => _productsService.quantityFocus;
  List<int> selectedCartProductsId = [];
  bool showCheckboxes = false;

  List<int> totalSum = [];

  onReady() {
    getData();
  }

  getData() async {
    try {
      await _productsService.getCartProduct();
      for (var i = 0; i < cartData!.cartproducts!.length; i++) {
        quantityFocus.add(FocusNode());
      }
      notifyListeners();
    } catch (e) {
      NavigationService.showErrorToast(e.toString());
    }
  }

  toCategoryScreen() {
    router.push(const CategoriesRoute());
  }

  toCheckoutScreen() {
    router.push(CheckoutRoute());
  }

  onProductTapped(ProductDto product) async {
    router.navigate(CartProductRoute(incomingProduct: product));
  }

  onChangeCount(String values, int index, {bool? isIncrement}) async {
    int? value = double.tryParse(productsQuantity[index].text)?.toInt();
    cartData!.cartproducts![index].quantity = value;
    cartData!.price = 0;
    for (var product in cartData!.cartproducts!) {
      cartData!.price = cartData!.price! + product.quantity! * product.product!.price!;
    }
    if (isIncrement != null && value != null) {
      isIncrement
          ? value++
          : value == 1
              ? null
              : value--;
    }

    if (value != null) {
      try {
        await changeCounInCart(value, index);
      } catch (e) {
        return;
      }
    }

    if (values.isEmpty && value != null) {
      productsQuantity[index].text = value.toString();
      for (var element in quantityFocus) {
        element.unfocus();
      }
    }
    notifyListeners();
  }

  Future<void> changeCounInCart(int value, int index) async {
    try {
      await _productsService.updateCartProduct(
          cartData!.cartproducts![index].product!.id!, value);
      cartData!.cartproducts![index].quantity = value;
      cartData!.price = 0;
      for (var product in cartData!.cartproducts!) {
        cartData!.price = cartData!.price! + product.quantity! * product.product!.price!;
      }
      rebuildUi();
    } catch (e) {
      print(e);
    }
  }

  onProductSelect(int productId) async {
    bool canVibrate = await Vibrate.canVibrate;
    if (canVibrate) {
      Vibrate.feedback(FeedbackType.light);
    }
    if (selectedCartProductsId.contains(productId)) {
      selectedCartProductsId.remove(productId);
      if (selectedCartProductsId.isEmpty) showCheckboxes = false;
    } else {
      selectedCartProductsId.add(productId);
      showCheckboxes = true;
    }

    notifyListeners();
  }

  delFromCart({ProductDto? product}) async {
    try {
      if (product != null) {
        product.isBusy = true;
        notifyListeners();
      }

      await _productsService.delFromCart(
          product != null ? [product.id!] : selectedCartProductsId);

      if (product != null) {
        cartData!.cartproducts!
            .removeWhere((element) => element.product!.id == product.id);
      } else {
        setBusy(true);
        for (var i = 0; i < selectedCartProductsId.length; i++) {
          cartData!.cartproducts!.removeWhere(
              (element) => element.product!.id == selectedCartProductsId[i]);
        }

        Future.delayed(const Duration(milliseconds: 500), () {
          rebuildUi();
        });
        selectedCartProductsId.clear();
        showCheckboxes = false;
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
    setBusy(false);
  }

  void rebuild() {
    rebuildUi();
  }
}
