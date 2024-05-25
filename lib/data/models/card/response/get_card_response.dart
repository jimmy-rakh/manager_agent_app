class GetCardResponse {
  String? id;
  String? name;
  String? ownerName;
  String? numberShort;

  GetCardResponse({this.id, this.name, this.ownerName, this.numberShort});

  GetCardResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    ownerName = json['owner_name'];
    numberShort = json['number_short'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['owner_name'] = ownerName;
    data['number_short'] = numberShort;
    return data;
  }
}