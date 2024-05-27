// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/domain/services/templates/templates_service.dart';
import 'package:bingo/presentation/bottom_sheets/product_sheets/product_details_sheet.dart';
import 'package:bingo/presentation/bottom_sheets/product_sheets/product_info_sheet.dart';
import 'package:bingo/presentation/bottom_sheets/product_sheets/product_review_sheet.dart';
import 'package:bingo/presentation/bottom_sheets/template_sheet/template_sheet.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:bingo/core/utils/formatters.dart';
import 'package:bingo/core/utils/share_utils.dart';
import 'package:bingo/data/models/products/response/cart_model.dart';
import 'package:bingo/data/models/products/response/product_model.dart';
import 'package:bingo/domain/services/navbar_service/navbar_service.dart';
import 'package:bingo/domain/services/navigation_service/navigation_service.dart';
import 'package:bingo/domain/services/products_service/products_service.dart';
import 'package:stacked/stacked.dart';

import '../../../domain/services/client_service.dart';

class ProductViewModel extends ReactiveViewModel {
  final ProductsService _productsService = getIt();
  final NavBarService _navBarService = getIt();
  final TemplateService _templateService = getIt();
  final ClientService _clientService = getIt();
  @override
  List<ListenableServiceMixin> get listenableServices => [_productsService,_clientService];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  CartDto? get cartData => _productsService.cartData;
  int? get inn => _clientService.inn;
  Stream? get stream => _productsService.stream;
  StreamController? get streamController => _productsService.controller;
  ProductDto? product ;
  TextEditingController productCountController =
      TextEditingController();
  FocusNode quantityFocus = FocusNode();

  bool isFromSearch = false;
  late int incomingNavIndex;
  bool get isSearching => _navBarService.firstScreenSearchStatus;

  ProductDto? incomingProduct;
  int? incomingProductId;

  onReady(
      {ProductDto? incomingProduct,
      int? incomingProductId,
      required int incomingNavIndex,
      required bool isFromSearch}) async {
    this.incomingProduct = incomingProduct;
    this.incomingProductId = incomingProductId;
    this.incomingNavIndex = incomingNavIndex;
    this.isFromSearch = isFromSearch;
    await getData();
    if(product == null ) getData();
    if (cartData!.cartproducts!.isNotEmpty && product!.inCart!) {
      productCountController.text = cartData!.cartproducts!
          .firstWhere((element) => element.product!.id == product!.id)
          .quantity!
          .toString();
    }
  }

  Future<void> getData() async {
    setBusy(true);
    try {
      product = await _productsService
          .fetchProductById(incomingProduct?.id ?? incomingProductId!);
       notifyListeners();
      if (stream != null && !streamController!.hasListener) {
        stream!.listen((event) => onReady(
            incomingNavIndex: incomingNavIndex,
            isFromSearch: isFromSearch,
            incomingProduct: incomingProduct,
            incomingProductId: incomingProductId));
      }
      notifyListeners();
    } catch (e) {
      print(e);
      setError(true);
    }
    setBusy(false);
  }

  showBottomBar(Widget child) {
    NavigationService.showBottomSheet(sheet: child);
  }

  onDispose() {
    if ((!_navBarService.firstScreenSearchStatus ||
            !_navBarService.firstScreenSearchStatus) &&
        isFromSearch) {
      _navBarService.changeSearchingValue(true, incomingNavIndex);
    }
  }

  onAddingToCart({ProductDto? similarProduct}) async {
    try {
      if (similarProduct != null) {
        similarProduct.isBusy = true;
      } else {
        product!.isBusy = true;
      }
      notifyListeners();
      if (similarProduct?.inCart ?? false) {
        await _productsService.delFromCart(inn,[similarProduct!.id!]);
      } else {

        await _productsService.addToCart(inn,
            similarProduct?.id ?? product!.id!,
            int.parse(similarProduct?.id != null
                ? '1'
                : productCountController.text == '' ? '1' : productCountController.text));

      }


      if (similarProduct != null) {
        similarProduct.inCart = true;
      } else {
        product!.inCart = true;
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
    if (similarProduct != null) {
      similarProduct.isBusy = false;
    } else {
      product!.isBusy = false;
    }
  }

  showProductInfo() {
    showBottomBar(ProductInfoSheet(
      data: product?.description ?? '',
    ));
  }

  showProductDetails() {
    showBottomBar(ProductDetailsSheet(
      characters: product!.productcharacters!,
    ));
  }

  showComments() {
    showBottomBar(ProductReviewSheet(
      reviews: product!.comments!,
    ));
  }

  onChangeCount(String values, {bool? isIncrement}) {
    int? value =  double.parse(productCountController.text).toInt();
    if (isIncrement != null) {
      if ((value >= product!.quantity! ||
              int.parse(values.isEmpty ? '0' : values) >= product!.quantity!) &&
          isIncrement) {
        NavigationService.showErrorToast(
            'error.quantity'.tr(args: [product!.quantity.toString()]));
        return;
      }
      isIncrement
          ? value++
          : value == 1
              ? null
              : value--;
    }
    if (values.isEmpty) {
      productCountController.text = value.toString();
      quantityFocus.unfocus();
    }
    cartData!.cartproducts!
        .firstWhereOrNull((element) => element.product!.id == product!.id)
        ?.quantity = value;
    notifyListeners();
    if (product!.inCart!) {
      // changeCounInCart();
    }
  }

  toCartPage() {
    router.navigate(const CartRoute());
  }

  addToFav() async {
    try {
      await _productsService.addToFav(product!.id!);
      product!.infav = true;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  delFromFav() async {
    try {
      await _productsService.delFromFav(product!.id!);
      product!.infav = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  changeCounInCart() async {
    try {
      await _productsService.updateCartProduct(
          product!.id!, int.parse(productCountController.text));
    } catch (e) {
      print(e);
    }
  }

  onProductTapped({ProductDto? product, int? productId}) async {
    print(incomingNavIndex);
    switch (incomingNavIndex) {
      case 0:
        router.push(HomeProductRoute(
            incomingProduct: product, incomingProductId: productId));
        break;
      case 2:
        router.push(CartProductRoute(
            incomingProduct: product, incomingProductId: productId));
        break;
      case 3:
        router.push(OrdersProductRoute(
            incomingProduct: product, incomingProductId: productId));
        break;
      default:
    }
  }

  Future<void> onRefresh() async {
    await getData();
  }

  onShare() {
    ShareService.share(
        '${product!.imageUrl}\n${product!.title}\n${Formatters.formattedMoney(product!.price)} ${'common.sum'.tr()}\n https://okans.uz/${product!.id}',
        subject: product!.title!);
  }

  void showTemplate() async {
    final res = await NavigationService.showBottomSheet(
        sheet: TemplateSheet(
      id: product!.id!,
    ));
    if (res != null) {
      addToTemplate(res);
    }
  }

  Future<void> addToTemplate(String templateId) async {
    try {
      await _templateService.addProductToTemplate(
          productId: product!.id!,
          templateId: templateId,
          quantity: int.parse(productCountController.text));
    } catch (e) {
      print(e);
    }
  }
}
