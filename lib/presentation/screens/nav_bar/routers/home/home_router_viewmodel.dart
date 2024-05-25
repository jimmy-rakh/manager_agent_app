import 'dart:async';
import 'package:bingo/app/locator.dart';
import 'package:bingo/data/models/search/search_request.dart';
import 'package:bingo/data/models/search/search_response.dart';
import 'package:bingo/domain/services/navbar_service/navbar_service.dart';
import 'package:bingo/domain/services/products_service/products_service.dart';
import 'package:bingo/domain/services/search_service/search_service.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class HomeRouterViewModel extends ReactiveViewModel {
  final NavBarService _navBarService = getIt();
  final SearchService _searchService = getIt();
  final ProductsService _productsService = getIt();

  final TextEditingController searchFieldController = TextEditingController();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_navBarService, _searchService, _productsService];

  bool get isSearching => _navBarService.firstScreenSearchStatus;
  Stream? get stream => _productsService.stream;
  StreamController? get streamController => _productsService.controller;
  final ScrollController searchScrollController = ScrollController();
  late List<String> autocomplateValues;

  bool isSearched = false;
  bool showSearchHistory = true;

  SearchResponse? searchedValues;

  FocusNode searchFocusNode = FocusNode();

  late SearchRequest searchRequest;

  late SearchRequest? specificSearchRequest;

  onReady() async{
    await _productsService.fetchPosters();
    await _productsService.fetchLastViewed();
  }


}
