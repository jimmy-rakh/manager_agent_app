class UserOrdersDto {
  int? count;
  String? next;
  String? previous;
  List<OrderDto>? results;

  UserOrdersDto({this.count, this.next, this.previous, this.results});

  UserOrdersDto.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <OrderDto>[];
      json['results'].forEach((v) {
        results!.add(OrderDto.fromJson(v));
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

class OrderDto {
  int? id;
  String? createdAt;
  String? status;
  String? payStatus;
  String? delivery;
  int? address;
  String? deliveryTime;
  String? paymethod;
  int? price;
  String? invoice;
  String? deliveryCost;
  int? count;

  OrderDto(
      {this.id,
        this.createdAt,
        this.status,
        this.payStatus,
        this.delivery,
        this.address,
        this.deliveryTime,
        this.paymethod,
        this.price,
        this.invoice,
        this.deliveryCost,
        this.count});

  OrderDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    status = json['status'];
    payStatus = json['pay_status'];
    delivery = json['delivery'];
    address = json['address'];
    deliveryTime = json['delivery_time'];
    paymethod = json['paymethod'];
    price = json['price'];
    invoice = json['invoice'];
    deliveryCost = json['delivery_cost'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['status'] = status;
    data['pay_status'] = payStatus;
    data['delivery'] = delivery;
    data['address'] = address;
    data['delivery_time'] = deliveryTime;
    data['paymethod'] = paymethod;
    data['price'] = price;
    data['invoice'] = invoice;
    data['delivery_cost'] = deliveryCost;
    data['count'] = count;
    return data;
  }
}
