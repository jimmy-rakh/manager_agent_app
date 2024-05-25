class UserModel {
  String? type;
  String? firstName;
  String? surname;
  String? lastname;
  List<String>? phoneNumbers;
  List<String>? messengers;
  String? avatarUrl;
  String? companyName;
  String? companyInn;
  int? notifyCount;
  String? id;
  String? typeName;
  String? name;
  String? phoneNumber;
  String? address;
  String? kindOfActivity;
  String? position;
  String? legalAddress;
  String? language;
  String? dateJoined;

  UserModel(
      {this.id,
      this.type,
      this.typeName,
      this.name,
      this.surname,
      this.lastname,
      this.phoneNumber,
      this.avatarUrl,
      this.address,
      this.kindOfActivity,
      this.position,
      this.legalAddress,
      this.companyName,
      this.companyInn,
      this.language,
      this.dateJoined,
      this.firstName,
      this.phoneNumbers,
      this.messengers,
      this.notifyCount});

  UserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    phoneNumbers = json['phone_numbers']?.cast<String>();
    messengers = json['messengers']?.cast<String>();
    notifyCount = json['notify_count'];
    id = json['id'];
    type = json['type'];
    typeName = json['type_name'];
    name = json['name'];
    surname = json['surname'];
    lastname = json['lastname'];
    phoneNumber = json['phone_number'];
    avatarUrl = json['avatar_url'];
    address = json['address'];
    kindOfActivity = json['kind_of_activity'];
    position = json['position'];
    legalAddress = json['legal_address'];
    companyName = json['company_name'];
    companyInn = json['company_inn'];
    language = json['language'];
    dateJoined = json['date_joined'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['phone_numbers'] = phoneNumbers;
    data['messengers'] = messengers;
    data['notify_count'] = notifyCount;
    data['id'] = id;
    data['type'] = type;
    data['type_name'] = typeName;
    data['name'] = name;
    data['surname'] = surname;
    data['lastname'] = lastname;
    data['phone_number'] = phoneNumber;
    data['avatar_url'] = avatarUrl;
    data['address'] = address;
    data['kind_of_activity'] = kindOfActivity;
    data['position'] = position;
    data['legal_address'] = legalAddress;
    data['company_name'] = companyName;
    data['company_inn'] = companyInn;
    data['language'] = language;
    data['date_joined'] = dateJoined;
    return data;
  }
}
