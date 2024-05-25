import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/core/styles/colors.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/data/models/categories/catigories_dto.dart';
import 'package:bingo/data/models/orders/response/order_list_dto.dart';
import 'package:bingo/data/models/products/response/cart_model.dart';
import 'package:bingo/data/models/products/response/favorites_model.dart';
import 'package:bingo/data/models/products/response/posters_model.dart';
import 'package:bingo/data/models/products/response/product_model.dart';
import 'package:bingo/data/models/template/response.dart';
import 'package:bingo/domain/services/navigation_service/navigation_service.dart';
import 'package:bingo/domain/services/order_service/order_service.dart';
import 'package:bingo/domain/services/products_service/products_service.dart';
import 'package:bingo/domain/services/search_service/search_service.dart';
import 'package:bingo/domain/services/templates/templates_service.dart';
import 'package:bingo/presentation/bottom_sheets/add_template/add_template_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends ReactiveViewModel {
  final ProductsService _productsService = getIt();
  final SearchService _searchService = getIt();
  final TemplateService _templateService = getIt();
  final OrderService _orderService = getIt();
  List<TextEditingController> quantityController = [];
  List<FocusNode> quantityFocus = [];

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_productsService, _searchService, _templateService, _orderService];



  ProductsPagination? get popularProducts =>
      _productsService.popularProducts;

  ProductsPagination? get lastViewedProducts =>
      _productsService.lastViewedProducts;



  CartDto? get cartData => _productsService.cartData;

  List<CategoriesDto> get allBrands => _searchService.allBrands;

  List<PostersDto> get postersList => _productsService.postersList;

  List<FavoriteDto>? get favorites => _productsService.favorites;

  List<TemplateResponse> get templates => _templateService.templates;

  bool get isBusyTemplates => _templateService.isBusy;

  List<OrderDto>? get unpaidOrders => _orderService.unpaidOrders?.results;

  ScrollController homeScreenScrollController = ScrollController();

  bool isType = true;
  bool loadMore = false;


  onReady() async {
    await getData();
    homeScreenScrollController.addListener(() {
      if (homeScreenScrollController.position.extentAfter < 100 &&
          !isBusy &&
          popularProducts?.next != null) {
        onLoadMore();
      }
    });

  }

  Future<void> getData() async {

    try {
      final res = await _productsService.fetchPopular();
      quantityFocus.addAll(List.generate(res, (index) => FocusNode()));
      quantityController.addAll(List.generate(res, (index) => TextEditingController()));
    } catch (e) {
      print(e);
    }
  }

  Future<void> onRefresh() async {
    await getData();
  }

  productType() async {
    isType =!isType;
    rebuildUi();
  }

  onProductTapped({ProductDto? product, int? productId}) async {
    unfocus();
    router.navigate(HomeProductRoute(
        incomingProduct: product, incomingProductId: productId));
  }

  toTamplate(TemplateResponse template) async {
    router.push(TemplateRoute(template: template));
  }

  onAddToCart(ProductDto product, {int? index}) async {
    unfocus();
    try {
      product.isBusy = true;
      notifyListeners();
      await _productsService.addToCart(
          product.id!,
          quantityController[index ?? 0].text == ''
              ? 1
              : int.parse(quantityController[index ?? 0].text));

      product.isBusy = false;
      notifyListeners();
      product.inCart = true;
      notifyListeners();
    } catch (e) {
      print(e);
    }

  }

  delFromCart(ProductDto product) async {
    unfocus();
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

  onLoadMore() async {
    if(popularProducts!.results!.length < 140){
    setBusy(true);
    try {
      final res = await _productsService.loadMorePopularProducts();

      quantityFocus.addAll(List.generate(res, (index) => FocusNode()));
      quantityController.addAll(List.generate(res, (index) => TextEditingController()));

      rebuildUi();
    } catch (e) {
      print(e);
    }

    setBusy(false);}
  }

  toSpecificProductsPage(String title) {
    // TODO NavigationService.pushNamed(
    //     routeName: NestedScreenRoutes.specificProductsView,
    //     navIndex: 0,
    //     arguments: SpecificProductsViewArguments(title: title));
  }

  void onCreateTemplate() {
    NavigationService.showBottomSheet(sheet: const AddTemplateSheet());
  }

  void onPay(int orderId) async {
    final res =
        await router.push(ConfirmPaymentRoute(orderId: orderId)) ?? false;

    if (res as bool) {
      NavigationService.showSnackBar(
          snackBar: SnackBar(
              backgroundColor: AppColors.green,
              content: Row(
                children: [
                  const Icon(
                    IconlyLight.shield_done,
                    color: Colors.white,
                    size: 32,
                  ),
                  horizontalSpace12,
                  Text(
                    'orders.success_payment'.tr(),
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              )));
      _orderService.fetchUnpaidOrders();
    }
  }

  void toOrder(int orderId) {
    router.push(OrderDetailsRoute(orderId: orderId));
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
        element.unfocus();
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

  void rebuild() {
    rebuildUi();
  }

  unfocus() {
    for (var focus in quantityFocus) {
      if(focus.hasFocus) focus.unfocus();
    }
  }
}
