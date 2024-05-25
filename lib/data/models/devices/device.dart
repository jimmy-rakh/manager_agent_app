class Device {
  Device({
    required this.deviceInfo,
    required this.deviceName,
    required this.deviceType,
    required this.imei,
    required this.appVersion,
  });
  late final String deviceInfo;
  late final String deviceName;
  late final int deviceType;
  late final String imei;
  late final String appVersion;

  Device.fromJson(Map<String, dynamic> json) {
    deviceInfo = json['info'];
    deviceName = json['name'];
    deviceType = json['type'];
    imei = json['imei'];
    appVersion = json['app_version'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['info'] = deviceInfo;
    data['name'] = deviceName;
    data['type'] = deviceType;
    data['imei'] = imei;
    data['app_version'] = appVersion;
    return data;
  }
}
