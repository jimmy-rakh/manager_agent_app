import 'dart:async';
import 'dart:io';
import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/core/network/constants.dart';
import 'package:bingo/data/models/products/response/product_model.dart';
import 'package:bingo/data/models/search/search_request.dart';
import 'package:bingo/data/models/search/search_response.dart';
import 'package:bingo/domain/services/navbar_service/navbar_service.dart';
import 'package:bingo/domain/services/navigation_service/navigation_service.dart';
import 'package:bingo/domain/services/products_service/products_service.dart';
import 'package:bingo/domain/services/search_service/search_service.dart';
import 'package:bingo/presentation/bottom_sheets/search_filter_sheet/search_filter_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import '../../../../../data/models/products/response/cart_model.dart';
import '../../../../../domain/services/client_service.dart';

class CategoriesRouterViewModel extends ReactiveViewModel {
  final NavBarService _navBarService = getIt();
  final SearchService _searchService = getIt();
  final ProductsService _productsService = getIt();
  final ClientService _clientService = getIt();
  CartDto? get cartData => _productsService.cartData;
  int? get inn => _clientService.inn;
  final TextEditingController searchFieldController = TextEditingController();
  List<TextEditingController> quantityController = [];
  List<FocusNode> quantityFocus = [];
  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_navBarService, _searchService, _productsService,_clientService];

  bool get isSearching => _navBarService.secondScreenSearchStatus;
  SearchResponse? get secondSearchVal => _searchService.secondSearchValue;
  Stream? get stream => _productsService.stream;
  StreamController? get streamController => _productsService.controller;
  bool get isSubCategoriesSelected => _searchService.isSubCategoriesSelected;
  final ScrollController searchScrollController = ScrollController();
  late List<String> autocomplateValues;

  bool isSearched = false;
  bool showSearchHistory = true;

  SearchResponse? searchedValues;

  FocusNode searchFocusNode = FocusNode();

  late SearchRequest searchRequest;

  late SearchRequest? specificSearchRequest;

  onReady() {
    // searchRequest = SearchRequest(
    //     url: NetworkConstants.searchProducts,
    //     title: searchFieldController.text,
    //     brands: [],
    //     categoryId: null,
    //     subcategoryId: null,
    //     priceFrom: null,
    //     priceTo: null,
    //     orderBy: ['-created_at']);
    // searchScrollController.addListener(() {
    //   if (searchScrollController.position.extentAfter < 100 &&
    //       !isBusy &&
    //       searchRequest.url != null &&
    //       isSearched) {
    //     search(loadMore: true);
    //   }
    // });
  }

  onSearch(String value, {bool onValueSearch = false}) async {
    if (!onValueSearch) return;
    isSearched = false;
    searchRequest.title = value;
    onValueSearch ? searchAutocomplete() : search();
    notifyListeners();
  }

  onClear(String? value) {
    searchFieldController.clear();
    if (value == null) {
      _navBarService.changeSearchingValue(false, 1);
      searchFocusNode.unfocus();
    }
    searchRequest.title = '';
    searchAutocomplete();
    isSearched = false;
    notifyListeners();
  }

  onProductTapped(ProductDto product) async {
    await router.navigate(CategoryProductRoute(
      isFromSearch: true,
      incomingProduct: product,
    ));
    _navBarService.changeSearchingValue(false, 1);
  }

  onAddToCart(ProductDto product, {int? index}) async {
    try {
      product.isBusy = true;
      notifyListeners();
      await _productsService.addToCart(inn,
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
      product.inCart = false;
      notifyListeners();

      await _productsService.delFromCart(inn,[product.id!]);
    } catch (e) {
      print(e);
    }
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
      NavigationService.showErrorToast('error.many_requests'.tr());
    }
  }

  searchAutocomplete() async {
    setBusy(true);
    if (searchFieldController.text.isEmpty) {
      showSearchHistory = true;
      notifyListeners();
    } else {
      showSearchHistory = false;
    }

    try {
      autocomplateValues =
          await _searchService.searchAutocomplete(searchRequest);
      autocomplateValues
          .removeWhere((element) => element.replaceAll(' ', '').isEmpty);
      notifyListeners();
    } catch (e) {
      // NavigationService.showErrorToast(e.toString());
    }
    setBusy(false);
  }

  search({bool loadMore = false}) async {
    setBusy(true);
    try {
      if (!loadMore) searchRequest.url = NetworkConstants.searchProducts;
      final res = await _searchService.search(searchRequest);
      quantityFocus.addAll(List.generate(res.results!.length, (index) => FocusNode()));
      quantityController.addAll(List.generate(res.results!.length, (index) => TextEditingController()));

      if (searchedValues == null || !loadMore) {
        searchedValues = res;
        searchRequest.url = res.next ?? NetworkConstants.searchProducts;

      } else {
        searchedValues!.results!.addAll(res.results!);
        searchRequest.url = res.next;

      }
      isSearched = true;

    } catch (e) {
      // NavigationService.showErrorToast(e.toString());
    }
    setBusy(false);
  }

  onSearchFieldTapped() {
    _searchService.clearCatData();
    _navBarService.changeSearchingValue(true, 1);
    notifyListeners();
  }

  onFilterTapped() async {
    final filterRes = await NavigationService.showBottomSheet(
        sheet: SearchFilterView(
      searchRequest: searchRequest,
    ));
    if (filterRes != null) {
      searchRequest = filterRes;
      notifyListeners();
      isSearched ? search() : searchAutocomplete();
    }
  }

  onAutocompleteTapped(String value) {
    searchRequest.title = value;
    searchFieldController.text = value;
    searchFocusNode.unfocus();
    notifyListeners();
    search();
  }

  onPanUpdate(DragUpdateDetails details) async {
    if (details.delta.dx > 25 && details.delta.dx < 100 && Platform.isIOS) {
      // if (isSearching) {
      //   _navBarService.changeSearchingValue(false, 0);
      //   searchFocusNode.unfocus();
      // } else if (NavigationService.canPop(navIndex: 0)) {
      //   NavigationService.back(navIndex: 0);
      // }
    }
  }

  Future<bool> onWillPop() async {
    if (isSearching) {
      _navBarService.changeSearchingValue(false, 1);
      searchFocusNode.unfocus();
    } else {
      // NavigationService.back(navIndex: 0);
    }
    notifyListeners();
    return false;
  }

  clearSearchHistory({String? title}) async {
    SearchRequest request = SearchRequest(title: title ?? '');
    try {
      await _searchService.clearSearchHistory(request);
      searchAutocomplete();
    } catch (e) {
      // NavigationService.showErrorToast(e.toString());
    }
  }

  toSpecificSearch(String url) {
    specificSearchRequest = SearchRequest(
        url: NetworkConstants.searchProducts,
        title: searchFieldController.text,
        brands: [],
        categoryId: null,
        subcategoryId: null,
        priceFrom: null,
        priceTo: null,
        orderBy: ['-created_at']);
    searchScrollController.addListener(() {
      if (searchScrollController.position.extentAfter < 100 &&
          !isBusy &&
          searchRequest.url != null &&
          isSearched) {
        search(loadMore: true);
      }
    });
  }


  void rebuild() {
    rebuildUi();
  }
}
