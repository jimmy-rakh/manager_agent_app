import 'package:bingo/data/models/products/response/cart_model.dart';
import '../../products/response/product_model.dart';

class OrderDetailsDto {
  int? id;
  RemoteManager? remoteManager;
  RemoteManager? picker;
  Client? client;
  String? createdAt;
  List<OrderDetails>? orderDetails;
  String? status;
  String? payStatus;
  String? delivery;
  String? deliveryCost;
  Address? address;
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
        this.remoteManager,
        this.picker,
        this.client,
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
    remoteManager = json['remote_manager'] != null
        ? new RemoteManager.fromJson(json['remote_manager'])
        : null;
    picker = json['picker'];
    client =
    json['client'] != null ? new Client.fromJson(json['client']) : null;
    createdAt = json['created_at'];
    if (json['order_details'] != null) {
      orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails!.add(new OrderDetails.fromJson(v));
      });
    }
    status = json['status'];
    payStatus = json['pay_status'];
    delivery = json['delivery'];
    deliveryCost = json['delivery_cost'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    deliveryTime = json['delivery_time'];
    paymethod = json['paymethod'];
    price = json['price'];
    discount = json['discount'];
    totalPrice = json['total_price'];
    invoice = json['invoice'];
    if (json['status_history'] != null) {
      statusHistory = <StatusHistory>[];
      json['status_history'].forEach((v) {
        statusHistory!.add(new StatusHistory.fromJson(v));
      });
    }
    if (json['pay_status_history'] != null) {
      payStatusHistory = <PaystatusHistory>[];
      json['pay_status_history'].forEach((v) {
        payStatusHistory!.add(new PaystatusHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.remoteManager != null) {
      data['remote_manager'] = this.remoteManager!.toJson();
    }
    data['picker'] = this.picker;
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    data['created_at'] = this.createdAt;
    if (this.orderDetails != null) {
      data['order_details'] =
          this.orderDetails!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['pay_status'] = this.payStatus;
    data['delivery'] = this.delivery;
    data['delivery_cost'] = this.deliveryCost;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['delivery_time'] = this.deliveryTime;
    data['paymethod'] = this.paymethod;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['total_price'] = this.totalPrice;
    data['invoice'] = this.invoice;
    if (this.statusHistory != null) {
      data['status_history'] =
          this.statusHistory!.map((v) => v.toJson()).toList();
    }
    if (this.payStatusHistory != null) {
      data['pay_status_history'] =
          this.payStatusHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class Client {
  int? id;
  String? type;
  String? fullName;
  List<String>? phoneNumbers;
  List<String>? messengers;
  String? avatarUrl;
  String? companyName;
  List<ClientBalances>? clientBalances;
  bool? active;

  Client(
      {this.id,
        this.type,
        this.fullName,
        this.phoneNumbers,
        this.messengers,
        this.avatarUrl,
        this.companyName,
        this.clientBalances,
        this.active});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    fullName = json['full_name'];
    phoneNumbers = json['phone_numbers'].cast<String>();
    if (json['messengers'] != null) {
      messengers = <String>[];
      json['messengers'].cast<String>();
    }
    avatarUrl = json['avatar_url'];
    companyName = json['company_name'];
    if (json['client_balances'] != null) {
      clientBalances = <ClientBalances>[];
      json['client_balances'].forEach((v) {
        clientBalances!.add(new ClientBalances.fromJson(v));
      });
    }
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['full_name'] = this.fullName;
    data['phone_numbers'] = this.phoneNumbers;
    if (this.messengers != null) {
      data['messengers'] = this.messengers;
    }
    data['avatar_url'] = this.avatarUrl;
    data['company_name'] = this.companyName;
    if (this.clientBalances != null) {
      data['client_balances'] =
          this.clientBalances!.map((v) => v.toJson()).toList();
    }
    data['active'] = this.active;
    return data;
  }
}

class ClientBalances {
  int? id;
  String? name;
  Balance? balance;

  ClientBalances({this.id, this.name, this.balance});

  ClientBalances.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    balance =
    json['balance'] != null ? new Balance.fromJson(json['balance']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.balance != null) {
      data['balance'] = this.balance!.toJson();
    }
    return data;
  }
}

class Balance {
  double? balance;
  int? limit;
  int? bonus;

  Balance({this.balance, this.limit, this.bonus});

  Balance.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    limit = json['limit'];
    bonus = json['bonus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    data['limit'] = this.limit;
    data['bonus'] = this.bonus;
    return data;
  }
}

class OrderDetails {
  int? id;
  Cartproduct? cartproduct;
  String? status;
  int? existsQuantity;

  OrderDetails({this.id, this.cartproduct, this.status, this.existsQuantity});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartproduct = json['cartproduct'] != null
        ? new Cartproduct.fromJson(json['cartproduct'])
        : null;
    status = json['status'];
    existsQuantity = json['exists_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.cartproduct != null) {
      data['cartproduct'] = this.cartproduct!.toJson();
    }
    data['status'] = this.status;
    data['exists_quantity'] = this.existsQuantity;
    return data;
  }
}

class Cartproduct {
  String? id;
  ProductDto? product;
  int? quantity;

  Cartproduct({this.id, this.product, this.quantity});

  Cartproduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? new ProductDto.fromJson(json['product']) : null;
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['quantity'] = this.quantity;
    return data;
  }
}



class Brand {
  int? id;
  String? name;

  Brand({this.id, this.name});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Address {
  String? title;
  String? latitude;
  String? longitude;
  List<String>? phoneNumbers;

  Address({this.title, this.latitude, this.longitude, this.phoneNumbers});

  Address.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    phoneNumbers = json['phone_numbers'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['phone_numbers'] = this.phoneNumbers;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}


class RemoteManager {
  int? id;
  String? fullName;
  List<String>? phoneNumbers;
  List<String>? messengers;
  String? avatarUrl;

  RemoteManager(
      {this.id,
        this.fullName,
        this.phoneNumbers,
        this.messengers,
        this.avatarUrl});

  RemoteManager.fromJson(Map<String, dynamic> json) {
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
