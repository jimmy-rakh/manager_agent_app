// ignore_for_file: depend_on_referenced_packages

import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/data/models/categories/catigories_dto.dart';
import 'package:bingo/data/models/search/search_quries.dart';
import 'package:bingo/data/models/search/search_request.dart';
import 'package:bingo/domain/services/navigation_service/navigation_service.dart';
import 'package:bingo/domain/services/search_service/search_service.dart';
import 'package:bingo/presentation/bottom_sheets/search_filter_sheet/pages/filter_by.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:stacked/stacked.dart';

class SearchFilterViewModel extends ReactiveViewModel {
  final SearchService _searchService = getIt();

  @override
  List<ListenableServiceMixin> get listenableServices => [_searchService];

  PageController pageController = PageController(initialPage: 0);

  List<CategoriesDto> get categoriesList => _searchService.categoriesList;

  List<CategoriesDto> subcategoriesList = [];
  List<SearchQueriesDto> get searchQueries => _searchService.searchQueries;
  List<String> filterBySelectedValues = [];

  CategoriesDto? choosedCategory;
  CategoriesDto? choosedSubcategory;
  CategoriesDto? choosedBrand;
  List<CategoriesDto>? searchBrandResponse;

  late SearchRequest searchRequest;

  onReady(SearchRequest searchRequest) {
    this.searchRequest = searchRequest;
    searchBrands();
    choosedCategory = categoriesList
        .firstWhereOrNull((element) => element.id == searchRequest.categoryId);
    choosedBrand = searchRequest.brands!.isEmpty
        ? null
        : CategoriesDto(name: searchRequest.brands?[0]);
    choosedSubcategory = subcategoriesList.firstWhereOrNull(
        (element) => element.id == searchRequest.subcategoryId);
  }

  changePage(int index) {
    pageController.jumpToPage(index);
  }

  chooseCategory(CategoriesDto category) async {
    choosedCategory = category;
    searchRequest.categoryId = category.id;
    choosedSubcategory = null;
    searchRequest.subcategoryId = null;
    pageController.jumpToPage(0);
    try {
      subcategoriesList = await _searchService.fetchSubcategoriesByCategory(
        category.id!,
      );
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  chooseSubcategory(CategoriesDto subcategory) {
    choosedSubcategory = subcategory;
    searchRequest.subcategoryId = subcategory.id;
    choosedBrand = null;
    searchRequest.brands!.clear();
    pageController.jumpToPage(0);
    searchBrands();
    notifyListeners();
  }

  chooseBrand(CategoriesDto brand) {
    choosedBrand = brand;
    searchRequest.brands!.add(brand.id.toString());
    pageController.jumpToPage(0);
    notifyListeners();
  }

  chooseFilterBy(FilterByValues orderBy) {
    searchRequest.orderBy?.add(orderBy.key);
    filterBySelectedValues.add(orderBy.value);
    notifyListeners();
  }

  searchBrands() async {
    try {
      final res = await _searchService.searchBrands(searchRequest);
      searchBrandResponse = res;
      notifyListeners();
    } catch (e) {
      NavigationService.showErrorToast(e.toString());
    }
  }

  changePriceRange(RangeValues value) {
    searchRequest.priceFrom = value.start.toInt();
    searchRequest.priceTo = value.end.toInt();
    notifyListeners();
  }

  onSubmit() {
    Navigator.pop(router.navigatorKey.currentContext!, searchRequest);
  }

  onReset() {}
}
