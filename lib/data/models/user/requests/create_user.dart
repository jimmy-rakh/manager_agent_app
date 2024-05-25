class CreateUserRequest {
  String? type;
  String? name;
  String? surname;
  String? lastname;
  String? phoneNumber;
  String? code;

  CreateUserRequest(
      {this.type,
      this.name,
      this.surname,
      this.lastname,
      this.phoneNumber,
      this.code});

  CreateUserRequest.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    name = json['name'];
    surname = json['surname'];
    lastname = json['lastname'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['name'] = name;
    data['surname'] = surname;
    data['lastname'] = lastname;
    data['phone_number'] = phoneNumber;
    data['code'] = code;
    return data;
  }
}
