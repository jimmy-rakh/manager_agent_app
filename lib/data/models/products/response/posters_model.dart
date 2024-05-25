class PostersDto {
  int? id;
  int? productId;
  String? imageUrl;

  PostersDto({this.id, this.productId, this.imageUrl});

  PostersDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['image_url'] = imageUrl;
    return data;
  }
}