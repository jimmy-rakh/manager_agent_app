import 'package:bingo/data/models/categories/catigories_dto.dart';

class SearchBrandResponse {
  int? count;
  String? next;
  String? previous;
  List<CategoriesDto>? results;

  SearchBrandResponse({this.count, this.next, this.previous, this.results});

  SearchBrandResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <CategoriesDto>[];
      json['results'].forEach((v) {
        results!.add(CategoriesDto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
