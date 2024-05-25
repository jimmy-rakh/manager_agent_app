class PaySubmitModel {
  int orderId;
  String? cardId;
  bool? byCash;
  bool? byTransfer;

  PaySubmitModel({
    required this.orderId,
    this.cardId,
    this.byCash,
    this.byTransfer,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cardId != null) data['card_id'] = cardId;
    if (byTransfer ?? false) data['transfer'] = byTransfer;
    return data;
  }
}
