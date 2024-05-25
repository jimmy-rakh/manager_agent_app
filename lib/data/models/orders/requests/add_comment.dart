class AddReviewRequest {
  int? productId;
  String? comment;
  int? rating;

  AddReviewRequest({this.productId, this.comment, this.rating});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['comment'] = comment;
    data['rating'] = rating;
    return data;
  }
}
