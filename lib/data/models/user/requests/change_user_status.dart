class ChangeUserStatusRequest {
  String? name;
  String? surname;
  String? lastname;
  String? type;
  String? address;
  String? kindOfActivity;
  String? position;
  String? legalAddress;
  String? companyName;
  String? companyInn;

  ChangeUserStatusRequest(
      {this.name,
      this.surname,
      this.lastname,
      this.type,
      this.address,
      this.kindOfActivity,
      this.position,
      this.legalAddress,
      this.companyName,
      this.companyInn});

  ChangeUserStatusRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    surname = json['surname'];
    lastname = json['lastname'];
    type = json['type'];
    address = json['address'];
    kindOfActivity = json['kind_of_activity'];
    position = json['position'];
    legalAddress = json['legal_address'];
    companyName = json['company_name'];
    companyInn = json['company_inn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) data['name'] = name;
    if (surname != null) data['surname'] = surname;
    if (lastname != null) data['lastname'] = lastname;
    if (type != null) data['type'] = type;
    if (address != null) data['address'] = address;
    if (kindOfActivity != null) data['kind_of_activity'] = kindOfActivity;
    if (position != null) data['position'] = position;
    if (legalAddress != null) data['legal_address'] = legalAddress;
    if (companyName != null) data['company_name'] = companyName;
    if (companyInn != null) data['company_inn'] = companyInn;
    return data;
  }
}
