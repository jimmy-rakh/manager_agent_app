
class AddressModel {
  int? id;
  String? title;
  String? latitude;
  String? longitude;
  List<String>? phoneNumbers;
  String? createdAt;

  AddressModel(
      {this.id, this.title, this.latitude, this.longitude, this.createdAt});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    if (json['phone_numbers'] != null) {
      phoneNumbers = <String>[];
      json['phone_numbers'].forEach((v) {
        phoneNumbers!.add(v);
      });
    }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['created_at'] = createdAt;
    return data;
  }
}
