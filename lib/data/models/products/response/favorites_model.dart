

import 'package:bingo/data/models/products/response/product_model.dart';

class FavoritesPagination {
  int? count;
  String? next;
  String? previous;
  List<FavoriteDto>? results;

  FavoritesPagination({this.count, this.next, this.previous, this.results});

  FavoritesPagination.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <FavoriteDto>[];
      json['results'].forEach((v) {
        results!.add(FavoriteDto.fromJson(v));
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

class FavoriteDto {
  late int id;
  late ProductDto product;

  FavoriteDto({required this.id, required this.product});

  FavoriteDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = ProductDto.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product'] = product;
    return data;
  }
}
