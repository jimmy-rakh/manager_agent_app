
import 'package:bingo/data/models/products/response/product_model.dart';

class SearchResponse {
  int? count;
  String? next;
  String? previous;
  List<ProductDto>? results;

  SearchResponse({this.count, this.next, this.previous, this.results});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <ProductDto>[];
      json['results'].forEach((v) {
        results!.add(ProductDto.fromJson(v));
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
