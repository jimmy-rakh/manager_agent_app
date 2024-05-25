class DeviceTokenDto {
  late String deviceToken;
  // late bool loged;

  DeviceTokenDto({required this.deviceToken});

  DeviceTokenDto.fromJson(Map<String, dynamic> json) {
    deviceToken = json['device_token'];
    // loged = json['loged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['device_token'] = deviceToken;
    // data['loged'] = loged;
    return data;
  }
}
