class OrdersDto {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  OrdersDto({this.count, this.next, this.previous, this.results});

  OrdersDto.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  bool? fromRemoteManager;
  String? createdAt;
  String? status;
  String? payStatus;
  String? delivery;
  int? address;
  String? deliveryTime;
  String? paymethod;
  int? price;
  int? discount;
  int? totalPrice;
  String? invoice;
  String? deliveryCost;
  int? count;

  Results(
      {this.id,
        this.fromRemoteManager,
        this.createdAt,
        this.status,
        this.payStatus,
        this.delivery,
        this.address,
        this.deliveryTime,
        this.paymethod,
        this.price,
        this.discount,
        this.totalPrice,
        this.invoice,
        this.deliveryCost,
        this.count});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromRemoteManager = json['from_remote_manager'];
    createdAt = json['created_at'];
    status = json['status'];
    payStatus = json['pay_status'];
    delivery = json['delivery'];
    address = json['address'];
    deliveryTime = json['delivery_time'];
    paymethod = json['paymethod'];
    price = json['price'];
    discount = json['discount'];
    totalPrice = json['total_price'];
    invoice = json['invoice'];
    deliveryCost = json['delivery_cost'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from_remote_manager'] = this.fromRemoteManager;
    data['created_at'] = this.createdAt;
    data['status'] = this.status;
    data['pay_status'] = this.payStatus;
    data['delivery'] = this.delivery;
    data['address'] = this.address;
    data['delivery_time'] = this.deliveryTime;
    data['paymethod'] = this.paymethod;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['total_price'] = this.totalPrice;
    data['invoice'] = this.invoice;
    data['delivery_cost'] = this.deliveryCost;
    data['count'] = this.count;
    return data;
  }
}
