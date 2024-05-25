import 'package:bingo/app/locator.dart';
import 'package:bingo/data/models/categories/catigories_dto.dart';
import 'package:bingo/data/models/categories/subcategory_request.dart';
import 'package:bingo/data/models/search/search_quries.dart';
import 'package:bingo/data/models/search/search_request.dart';
import 'package:bingo/data/models/search/search_response.dart';
import 'package:bingo/data/sources/local/storage.dart';
import 'package:bingo/data/sources/network/search_api.dart';

abstract class SearchReposiory {
  Future<SearchResponse> search(SearchRequest request);

  Future<List<CategoriesDto>> fetchAllCategories();

  Future<List<CategoriesDto>> fetchSubcategoriesByCategory(
      SubCategoryRequest request);

  Future<List<CategoriesDto>> fetchAllBrands();

  Future<List<CategoriesDto>> searchBrands(SearchRequest request);

  Future<List<SearchQueriesDto>> fetchSearchQueries();

  Future<List<String>> searchAutocomplates(SearchRequest request);

  Future clearSearchHistory(SearchRequest request);

  void saveCategories(List<CategoriesDto> categories);

  List<CategoriesDto> getCategories();
}

class SearchReposioryImpl implements SearchReposiory {
  final _api = getIt<SearchApiImpl>();
  final LocalStorage _localStorage = getIt<LocalStorageImpl>();
  @override
  Future<SearchResponse> search(SearchRequest request) async {
    try {
      return await _api.search(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CategoriesDto>> fetchAllCategories() async {
    try {
      return await _api.fetchAllCategories();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CategoriesDto>> fetchSubcategoriesByCategory(
      SubCategoryRequest request) async {
    try {
      return await _api.fetchSubcategoriesByCategory(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CategoriesDto>> fetchAllBrands() async {
    try {
      return await _api.fetchAllBrands();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CategoriesDto>> searchBrands(SearchRequest request) async {
    try {
      return await _api.searchBrands(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SearchQueriesDto>> fetchSearchQueries() async {
    try {
      return await _api.fetchSearchQueries();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<String>> searchAutocomplates(SearchRequest request) async {
    try {
      return await _api.searchAutocomplates(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future clearSearchHistory(SearchRequest request) async {
    try {
      return await _api.clearSearchHistory(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  List<CategoriesDto> getCategories() {
    return _localStorage.getCategories();
  }

  @override
  void saveCategories(List<CategoriesDto> categories) {
    _localStorage.setCategories(categories);
  }
}
