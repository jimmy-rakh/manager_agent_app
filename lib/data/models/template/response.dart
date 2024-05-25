import 'package:bingo/data/models/products/response/cart_model.dart';

class TemplateResponse {
  String? id;
  String? name;
  List<Cartproducts>? templateproducts;
  int? price;
  int? productsCount;

  TemplateResponse(
      {this.id,
      this.name,
      this.price,
      this.productsCount,
      this.templateproducts});

  TemplateResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['templateproducts'] != null) {
      templateproducts = <Cartproducts>[];
      json['templateproducts'].forEach((v) {
        templateproducts!.add(Cartproducts.fromJson(v));
      });
    }
    price = json['price'];
    productsCount = json['products_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (templateproducts != null) {
      data['templateproducts'] =
          templateproducts!.map((v) => v.toJson()).toList();
    }
    data['price'] = price;
    data['products_count'] = productsCount;
    return data;
  }
}
