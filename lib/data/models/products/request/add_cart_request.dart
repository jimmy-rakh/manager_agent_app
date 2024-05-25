class AddCartRequest {
  int? productId;
  int? cartProductId;
  int? quantity;
  List<int>? cartProductsIds;

  AddCartRequest(
      {this.productId,
      this.quantity,
      this.cartProductsIds,
      this.cartProductId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productId != null) data['product_id'] = productId;
    if (cartProductId != null) data['cartproduct_id'] = cartProductId;
    if (quantity != null) data['quantity'] = quantity;
    if (cartProductsIds != null) data['products_ids'] = cartProductsIds;
    return data;
  }
}
