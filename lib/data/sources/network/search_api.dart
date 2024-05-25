import 'package:bingo/app/locator.dart';
import 'package:bingo/core/network/constants.dart';
import 'package:bingo/core/network/globuskans_api_service.dart';
import 'package:bingo/data/models/categories/catigories_dto.dart';
import 'package:bingo/data/models/categories/subcategory_request.dart';
import 'package:bingo/data/models/search/search_quries.dart';
import 'package:bingo/data/models/search/search_request.dart';
import 'package:bingo/data/models/search/search_response.dart';

abstract class SearchApi {
  Future<SearchResponse> search(SearchRequest request);

  Future<List<CategoriesDto>> fetchAllCategories();

  Future<List<CategoriesDto>> fetchSubcategoriesByCategory(
      SubCategoryRequest request);

  Future<List<CategoriesDto>> fetchAllBrands();

  Future<List<CategoriesDto>> searchBrands(SearchRequest request);

  Future<List<SearchQueriesDto>> fetchSearchQueries();

  Future<List<String>> searchAutocomplates(SearchRequest request);

  Future clearSearchHistory(SearchRequest request);
}

class SearchApiImpl implements SearchApi {
  final BingoApi _api = getIt();

  @override
  Future<SearchResponse> search(SearchRequest request) async {
    try {
      final res = await _api.post(request.url!, data: request.toJson());
      return SearchResponse.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CategoriesDto>> fetchAllCategories() async {
    try {
      final res = await _api.get(NetworkConstants.categories);

      final List<CategoriesDto> myList = List.from(res['results'])
          .map((e) => CategoriesDto.fromJson(e))
          .toList();

      return myList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CategoriesDto>> fetchSubcategoriesByCategory(
      SubCategoryRequest request) async {
    try {
      final res = await _api.get(
        NetworkConstants.subCategories
            .replaceAll('category', request.categoryId.toString()),
      );

      final List<CategoriesDto> myList = List.from(res['results'])
          .map((e) => CategoriesDto.fromJson(e))
          .toList();

      return myList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CategoriesDto>> fetchAllBrands() async {
    try {
      final res = await _api.get(NetworkConstants.fetchBrands);
      final List<CategoriesDto> myList = List.from(res['results'])
          .map((e) => CategoriesDto.fromJson(e))
          .toList();
      return myList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CategoriesDto>> searchBrands(SearchRequest request) async {
    try {
      final res = await _api.post(NetworkConstants.searchBrands,
          data: request.toJson());
      final List<CategoriesDto> myList =
          List.from(res).map((e) => CategoriesDto.fromJson(e)).toList();
      return myList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SearchQueriesDto>> fetchSearchQueries() async {
    try {
      final res = await _api.get(NetworkConstants.searchProducts);
      final List<SearchQueriesDto> myList = List.from(res['results'])
          .map((e) => SearchQueriesDto.fromJson(e))
          .toList();
      return myList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<String>> searchAutocomplates(SearchRequest request) async {
    try {
      final res = await _api.post(NetworkConstants.searchAutocomplete,
          data: request.toJson());
      final List<String> myList =
          List.from(res['autocomplete']).map((e) => e.toString()).toList();
      return myList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future clearSearchHistory(SearchRequest request) async {
    try {
      final res = await _api.delete(NetworkConstants.searchAutocomplete,
          data: request.toJson());

      return res;
    } catch (e) {
      rethrow;
    }
  }
}
