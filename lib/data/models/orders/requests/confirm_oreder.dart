class ConfirmOrderRequest {
  final int orderId;
  final String sign;

  ConfirmOrderRequest({
    required this.sign,
    required this.orderId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sign'] = sign;
    return data;
  }
}
