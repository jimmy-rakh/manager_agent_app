import 'package:bingo/app/locator.dart';
import 'package:bingo/core/network/constants.dart';
import 'package:bingo/data/models/categories/catigories_dto.dart';
import 'package:bingo/data/models/categories/subcategory_request.dart';
import 'package:bingo/data/models/search/search_quries.dart';
import 'package:bingo/data/models/search/search_request.dart';
import 'package:bingo/data/models/search/search_response.dart';
import 'package:bingo/domain/repositories/search_repository.dart';
import 'package:stacked/stacked.dart';

class SearchService with ListenableServiceMixin {
  final SearchReposiory _searchReposiory = getIt<SearchReposioryImpl>();

  final ReactiveValue<List<CategoriesDto>> _categoriesList = ReactiveValue([]);
  final ReactiveValue<List<CategoriesDto>> _allBrands = ReactiveValue([]);
  final ReactiveValue<List<SearchQueriesDto>> _searchQueries =
      ReactiveValue([]);
  final ReactiveValue<SearchRequest> _specificSearchRequest = ReactiveValue(
      SearchRequest(
          url: NetworkConstants.searchProducts,
          title: '',
          brands: [],
          categoryId: null,
          subcategoryId: null,
          priceFrom: null,
          priceTo: null,
          orderBy: ['-created_at']));
  final ReactiveValue<SearchResponse?> _secondSearchValue = ReactiveValue(null);
  final ReactiveValue<bool> _isSubCategoriesSelected = ReactiveValue(false);

  List<CategoriesDto> get categoriesList => _categoriesList.value;
  List<SearchQueriesDto> get searchQueries => _searchQueries.value;
  List<CategoriesDto> get allBrands => _allBrands.value;
  SearchRequest get specificSearchRequest => _specificSearchRequest.value;
  SearchResponse? get secondSearchValue => _secondSearchValue.value;
  bool get isSubCategoriesSelected => _isSubCategoriesSelected.value;

  SearchService() {
    listenToReactiveValues([
      _categoriesList,
      _allBrands,
      _searchQueries,
      _specificSearchRequest,
      _secondSearchValue,
      _isSubCategoriesSelected,
    ]);
  }

  Future<SearchResponse> search(
    SearchRequest request, {
    bool subcategorieSelected = false,
  }) async {
    try {
      clearCatData();

      final res = await _searchReposiory.search(request);
      _isSubCategoriesSelected.value = subcategorieSelected;
      if (subcategorieSelected) {
        _secondSearchValue.value = res;
      }
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchAllCategories() async {
    try {
      _categoriesList.value = await _searchReposiory.fetchAllCategories();
      await fetchAllSubcategories();
      _searchReposiory.saveCategories(categoriesList);
    } catch (e) {
      rethrow;
    }
  }

  fetchAllSubcategories() async {
    for (final category in categoriesList) {
      category.subCategories = await fetchSubcategoriesByCategory(category.id!);
    }
  }

  Future<List<CategoriesDto>> fetchSubcategoriesByCategory(
      int categoryId) async {
    try {
      SubCategoryRequest request = SubCategoryRequest(categoryId: categoryId);

      final res = await _searchReposiory.fetchSubcategoriesByCategory(request);

      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchAllBrands() async {
    try {
      _allBrands.value = await _searchReposiory.fetchAllBrands();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CategoriesDto>> searchBrands(SearchRequest request) async {
    try {
      return await _searchReposiory.searchBrands(request);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchSearchQueries() async {
    try {
      _searchQueries.value = await _searchReposiory.fetchSearchQueries();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String>> searchAutocomplete(SearchRequest request) async {
    try {
      return await _searchReposiory.searchAutocomplates(request);
    } catch (e) {
      rethrow;
    }
  }

  Future clearSearchHistory(SearchRequest request) async {
    try {
      return await _searchReposiory.clearSearchHistory(request);
    } catch (e) {
      rethrow;
    }
  }

  updateSearchRequest({SearchRequest? request}) {
    _specificSearchRequest.value = request ??
        SearchRequest(
            url: NetworkConstants.searchProducts,
            title: '',
            brands: [],
            categoryId: null,
            subcategoryId: null,
            priceFrom: null,
            priceTo: null,
            orderBy: ['-created_at']);
  }

  void clearCatData() {
    _secondSearchValue.value = null;
    _isSubCategoriesSelected.value = false;
  }

  void getLocalCategories() {
    _categoriesList.value = _searchReposiory.getCategories();
  }
}
