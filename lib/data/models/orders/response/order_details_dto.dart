import 'package:bingo/data/models/products/response/cart_model.dart';

class OrderDetailsDto {
  int? id;
  Manager? manager;
  String? createdAt;
  List<OrderProductsDto>? orderDetails;
  String? status;
  String? payStatus;
  String? delivery;
  String? deliveryCost;
  String? address;
  String? deliveryTime;
  String? paymethod;
  int? price;
  int? discount;
  int? totalPrice;
  String? invoice;
  List<StatusHistory>? statusHistory;
  List<PaystatusHistory>? payStatusHistory;

  OrderDetailsDto(
      {this.id,
      this.createdAt,
      this.orderDetails,
      this.status,
      this.payStatus,
      this.delivery,
      this.deliveryCost,
      this.address,
      this.deliveryTime,
      this.paymethod,
      this.price,
      this.discount,
      this.totalPrice,
      this.invoice,
      this.statusHistory,
      this.payStatusHistory});

  OrderDetailsDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    manager =
    json['manager'] != null ?  Manager.fromJson(json['manager']) : null;
    createdAt = json['created_at'];
    if (json['order_details'] != null) {
      orderDetails = <OrderProductsDto>[];
      json['order_details'].forEach((v) {
        orderDetails!.add(OrderProductsDto.fromJson(v));
      });
    }
    status = json['status'];
    payStatus = json['pay_status'];
    delivery = json['delivery'];
    deliveryCost = json['delivery_cost'];
    address = json['address'];
    deliveryTime = json['delivery_time'];
    paymethod = json['paymethod'];
    price = json['price'];
    invoice = json['invoice'];
    if (json['status_history'] != null) {
      statusHistory = <StatusHistory>[];
      json['status_history'].forEach((v) {
        statusHistory!.add(StatusHistory.fromJson(v));
      });
    }
    if (json['pay_status_history'] != null) {
      payStatusHistory = <PaystatusHistory>[];
      json['pay_status_history'].forEach((v) {
        payStatusHistory!.add(PaystatusHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (manager != null) {
      data['manager'] = manager!.toJson();
    }
    data['created_at'] = createdAt;
    if (orderDetails != null) {
      data['order_details'] = orderDetails!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['pay_status'] = payStatus;
    data['delivery'] = delivery;
    data['delivery_cost'] = deliveryCost;
    data['address'] = address;
    data['delivery_time'] = deliveryTime;
    data['paymethod'] = paymethod;
    data['price'] = price;
    data['invoice'] = invoice;
    if (statusHistory != null) {
      data['status_history'] = statusHistory!.map((v) => v.toJson()).toList();
    }
    if (payStatusHistory != null) {
      data['pay_status_history'] =
          payStatusHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Manager {
  int? id;
  String? fullName;
  List<String>? phoneNumbers;
  List<String>? messengers;
  String? avatarUrl;

  Manager(
      {this.id,
        this.fullName,
        this.phoneNumbers,
        this.messengers,
        this.avatarUrl});

  Manager.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    phoneNumbers = json['phone_numbers'].cast<String>();
    messengers = json['messengers'].cast<String>();
    avatarUrl = json['avatar_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['phone_numbers'] = this.phoneNumbers;
    data['messengers'] = this.messengers;
    data['avatar_url'] = this.avatarUrl;
    return data;
  }
}

class StatusHistory {
  String? status;
  String? createdAt;

  StatusHistory({this.status, this.createdAt});

  StatusHistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}

class PaystatusHistory {
  String? status;
  String? createdAt;

  PaystatusHistory({this.status, this.createdAt});

  PaystatusHistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}

class OrderProductsDto {
  int? id;
  CartDto? cartproduct;
  int? existsQuantity;

  OrderProductsDto({this.id, this.cartproduct,this.existsQuantity});

  OrderProductsDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartproduct = json['cartproduct'] != null
        ? CartDto.fromJson(json['cartproduct'])
        : null;
    existsQuantity = json['exists_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (cartproduct != null) {
      data['cartproduct'] = cartproduct!.toJson();
    }
    data['exists_quantity'] = this.existsQuantity;
    return data;
  }
}
