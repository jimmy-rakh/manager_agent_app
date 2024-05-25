class SearchRequest {
  String? url;
  String? title;
  List<String>? brands;
  int? categoryId;
  int? subcategoryId;
  int? priceFrom;
  int? priceTo;
  List<String>? orderBy;

  SearchRequest(
      {this.url,
      this.title,
      this.brands,
      this.categoryId,
      this.subcategoryId,
      this.priceFrom,
      this.priceTo,
      this.orderBy});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (title != null) data['title'] = title;
    if (brands != null) data['brands'] = brands;
    if (categoryId != null) data['category_id'] = categoryId;
    if (subcategoryId != null) data['subcategory_id'] = subcategoryId;
    if (priceFrom != null) data['price_from'] = priceFrom;
    if (priceTo != null) data['price_to'] = priceTo;
    if (orderBy != null) data['order_by'] = orderBy;
    return data;
  }
}
