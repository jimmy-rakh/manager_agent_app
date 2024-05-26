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
    messengers = json['messengers'].cast<String>();
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
