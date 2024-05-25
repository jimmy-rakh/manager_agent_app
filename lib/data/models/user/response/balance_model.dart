class BalanceDto {
  double? balance;
  int? limit;

  BalanceDto({this.balance});

  BalanceDto.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['balance'] = balance;
    data['limit'] = limit;
    return data;
  }
}
