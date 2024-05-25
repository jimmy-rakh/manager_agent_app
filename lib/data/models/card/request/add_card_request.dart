class AddCardRequest {
  String? name;
  String? ownerName;
  String? number;
  String? expire;

  AddCardRequest({this.name, this.ownerName, this.number, this.expire});

  AddCardRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    ownerName = json['owner_name'];
    number = json['number'];
    expire = json['expire'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['owner_name'] = ownerName;
    data['number'] = number;
    data['expire'] = expire;
    return data;
  }
}
