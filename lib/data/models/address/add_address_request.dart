class AddAddressRequestModel {
  String? title;
  String? latitude;
  String? longitude;
  List<String>? phoneNumbers;

  AddAddressRequestModel({this.title, this.latitude, this.longitude, this.phoneNumbers});

  AddAddressRequestModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    phoneNumbers = json['phone_numbers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['phone_numbers'] = phoneNumbers;
    return data;
  }
}
