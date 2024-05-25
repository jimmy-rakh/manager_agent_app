import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/core/network/constants.dart';
import 'package:bingo/data/models/products/response/product_model.dart';
import 'package:bingo/data/models/search/search_request.dart';
import 'package:bingo/data/models/search/search_response.dart';
import 'package:bingo/domain/services/search_service/search_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SelectorViewModel extends ReactiveViewModel {
  final _searchService = getIt<SearchService>();

  List<ProductDto> selectedProducts = [];
  bool showSelectedProducts = true;
  TextEditingController textEditingController = TextEditingController();

  SearchRequest request = SearchRequest(
    url: NetworkConstants.searchProducts,
    title: '',
    brands: [],
    categoryId: null,
    subcategoryId: null,
    priceFrom: null,
    priceTo: null,
    orderBy: ['-created_at'],
  );
  ScrollController scrollController = ScrollController();

  late SearchResponse searchResponse;
  bool loadingMore = false;

  void onReady() {
    search();
    scrollController.addListener(() {
      if (scrollController.position.extentAfter < 100 &&
          !loadingMore &&
          request.url != null) {
        search(loadMore: true);
      }
    });
  }

  Future<void> search({
    String? name,
    bool loadMore = false,
  }) async {
    if (!loadMore) setBusy(true);
    if (loadMore) loadingMore = true;
    request.title = name;
    rebuildUi();
    try {
      if (!loadMore) request.url = NetworkConstants.searchProducts;
      final res = await _searchService.search(request);
      request.url = res.next;
      if (loadMore == false) {
        searchResponse = res;
      } else {
        searchResponse.results!.addAll(res.results!);
        searchResponse.next = res.next;
      }
      if (loadMore) loadingMore = false;
      rebuildUi();
    } catch (e) {
      print(e.toString());
    }
    if (!loadMore) setBusy(false);
  }

  void onAddProduct({ProductDto? product}) {
    if (selectedProducts.contains(product)) {
      selectedProducts.remove(product!);
      rebuildUi();
      return;
    }
    selectedProducts.add(product!);
    rebuildUi();
  }

  void selectedProductsVisibilityToogle() {
    showSelectedProducts = !showSelectedProducts;
    rebuildUi();
  }

  void onDone() {
    router.pop(selectedProducts);
  }
}
