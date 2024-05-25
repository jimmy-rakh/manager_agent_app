
import 'package:bingo/app/locator.dart';
import 'package:bingo/data/models/categories/catigories_dto.dart';
import 'package:bingo/data/models/search/search_request.dart';
import 'package:bingo/domain/services/search_service/search_service.dart';
import 'package:stacked/stacked.dart';

class CategoriesViewModel extends ReactiveViewModel {
  final SearchService _searchService = getIt();

  @override
  List<ListenableServiceMixin> get listenableServices => [_searchService];

  List<CategoriesDto> get categoriesList => _searchService.categoriesList;
  SearchRequest get searchRequest => _searchService.specificSearchRequest;

  onReady() {
    getData();
  }

  getData() async {
    _searchService.getLocalCategories();
  }
}
