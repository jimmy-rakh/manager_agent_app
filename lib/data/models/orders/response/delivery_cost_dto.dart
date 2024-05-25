class DeliveryCostDto {
  int? cost;

  DeliveryCostDto({this.cost});

  DeliveryCostDto.fromJson(Map<String, dynamic> json) {
    cost = json['cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cost'] = cost;
    return data;
  }
}