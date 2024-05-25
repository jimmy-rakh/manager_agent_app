import 'package:bingo/data/models/products/response/product_model.dart';

class CartDto {
  String? id;
  List<Cartproducts>? cartproducts;
  ProductDto? product;
  int? price;
  int? quantity;

  CartDto({this.id, this.cartproducts, this.price, this.product});

  CartDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['cartproducts'] != null) {
      cartproducts = <Cartproducts>[];
      json['cartproducts'].forEach((v) {
        cartproducts!.add(Cartproducts.fromJson(v));
      });
    }

    product =
        json['product'] == null ? null : ProductDto.fromJson(json['product']);
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (cartproducts != null) {
      data['cartproducts'] = cartproducts!.map((v) => v.toJson()).toList();
    }
    data['price'] = price;
    data['quantity'] = quantity;
    return data;
  }
}

class Cartproducts {
  String? id;
  ProductDto? product;
  int? quantity;

  Cartproducts({this.id, this.product, this.quantity});

  Cartproducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? ProductDto.fromJson(json['product']) : null;
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['quantity'] = quantity;
    return data;
  }
}
