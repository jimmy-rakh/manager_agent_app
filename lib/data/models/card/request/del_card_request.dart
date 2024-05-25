class DeleteCardRequest {
  String? cardId;

  DeleteCardRequest({this.cardId});

  DeleteCardRequest.fromJson(Map<String, dynamic> json) {
    cardId = json['card_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['card_id'] = cardId;
    return data;
  }
}
