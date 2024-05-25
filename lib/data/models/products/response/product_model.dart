import 'package:bingo/data/models/categories/catigories_dto.dart';
import 'package:bingo/data/models/user/response/user_model.dart';

class ProductsPagination {
  int? count;
  String? next;
  String? previous;
  List<ProductDto>? results;
  List<SingleProductDto>? singleResults;

  ProductsPagination(
      {this.count, this.next, this.previous, this.results, this.singleResults});

  ProductsPagination.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <ProductDto>[];
      singleResults = <SingleProductDto>[];
      json['results'].forEach((v) {
        results!.add(ProductDto.fromJson(v));
        singleResults!.add(SingleProductDto.fromJson(v));
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

class SingleProductDto {
  ProductDto? product;

  SingleProductDto({this.product});

  SingleProductDto.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? ProductDto.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product'] = product;
    return data;
  }
}

class ProductDto {
  int? id;
  String? provider;
  int? providerId;
  CategoriesDto? brand;
  List<CategoriesDto>? subcategories;
  String? category;
  String? categoryId;
  String? subcategory;
  int? subcategoryId;
  String? title;
  String? description;
  List<ProductCharacters>? productcharacters;
  int? price;
  int? discount;
  int? priceDiscount;
  List<ProductCommentsDto>? comments;
  String? imageUrl;
  List<Gallery>? gallery;
  String? status;
  double? rating;
  int? quantity;
  String? measure;
  String? quantityInBox;
  bool? bought;
  bool? comment;
  bool? infav;
  bool? inCart;
  bool? isBusy;
  bool? hasComment;

  ProductDto(
      {this.id,
      this.provider,
      this.providerId,
      this.category,
      this.categoryId,
      this.subcategory,
      this.subcategoryId,
      this.title,
      this.description,
      this.productcharacters,
      this.price,
      this.discount,
      this.priceDiscount,
      this.comments,
      this.imageUrl,
      this.gallery,
      this.status,
      this.rating,
      this.quantity,
        this.measure,
        this.quantityInBox,
      this.bought,
      this.comment,
      this.infav,
      this.inCart,
      this.isBusy = false,
      this.hasComment});

  ProductDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provider = json['provider'];
    providerId = json['provider_id'];
    brand =
        json['brand'] != null ? CategoriesDto.fromJson(json['brand']) : null;
    if (json['subcategories'] != null) {
      subcategories = <CategoriesDto>[];
      json['subcategories'].forEach((v) {
        subcategories!.add(CategoriesDto.fromJson(v));
      });
    }
    category = json['category'];
    categoryId = json['category_id'];
    subcategory = json['subcategory'];
    subcategoryId = json['subcategory_id'];
    title = json['title'];
    description = json['description'];
    if (json['characters'] != null) {
      productcharacters = <ProductCharacters>[];
      json['characters'].forEach((v) {
        productcharacters!.add(ProductCharacters.fromJson(v));
      });
    }
    price = json['price'];
    discount = json['discount'];
    priceDiscount = json['price_discount'];
    if (json['comments'] != null) {
      comments = <ProductCommentsDto>[];
      json['comments'].forEach((v) {
        comments!.add(ProductCommentsDto.fromJson(v));
      });
    }
    imageUrl = json['image_url'];
    if (json['gallery'] != null) {
      gallery = <Gallery>[];
      json['gallery'].forEach((v) {
        gallery!.add(Gallery.fromJson(v));
      });
    }
    status = json['status'];
    rating = json['rating'];
    quantity = json['quantity'];
    measure = json['measure'];
    quantityInBox = json['quantity_in_box'];
    bought = json['bought'];
    comment = json['comment'];
    infav = json['infav'];
    inCart = json['incart'] ?? false;
    isBusy = false;
    hasComment = json['hascomment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['provider'] = provider;
    data['provider_id'] = providerId;
    data['brand'] = brand?.toJson();
    if (subcategories != null) {
      data['subcategories'] = subcategories!.map((v) => v.toJson()).toList();
    }
    data['category'] = category;
    data['category_id'] = categoryId;
    data['subcategory'] = subcategory;
    data['subcategory_id'] = subcategoryId;
    data['title'] = title;
    data['description'] = description;
    if (productcharacters != null) {
      data['characters'] = productcharacters!.map((v) => v.toJson()).toList();
    }
    data['price'] = price;
    data['discount'] = discount;
    data['price_discount'] = priceDiscount;
    if (comments != null) {
      data['product_comments'] = comments!.map((v) => v).toList();
    }
    data['image_url'] = imageUrl;
    if (gallery != null) {
      data['gallery'] = gallery!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['rating'] = rating;
    data['quantity'] = quantity;
    data['measure'] = measure;
    data['quantity_in_box'] = quantityInBox;
    data['bought'] = bought;
    data['comment'] = comment;
    data['infav'] = infav;
    data['incart'] = inCart;
    data['hascomment'] = hasComment;
    return data;
  }
}

class ProductCharacters {
  int? id;
  String? key;
  String? value;

  ProductCharacters({this.id, this.key, this.value});

  ProductCharacters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}

class Gallery {
  String? imageUrl;

  Gallery({this.imageUrl});

  Gallery.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_url'] = imageUrl;
    return data;
  }
}

class ProductCommentsDto {
  int? id;
  String? comment;
  int? rating;
  UserModel? client;

  ProductCommentsDto({this.id, this.comment, this.rating, this.client});

  ProductCommentsDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    rating = json['rating'];
    client = json['client'] != null ? UserModel.fromJson(json['client']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comment'] = comment;
    data['rating'] = rating;
    if (client != null) {
      data['client'] = client!.toJson();
    }
    return data;
  }
}
