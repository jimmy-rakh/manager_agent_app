import 'package:bingo/data/models/devices/device.dart';

class RegisterDeviceTokenRequest {
  RegisterDeviceTokenRequest({
    required this.device,
    required this.fcmToken,
  });
  late final Device device;
  late final String fcmToken;

  RegisterDeviceTokenRequest.fromJson(Map<String, dynamic> json) {
    device = Device.fromJson(json['device']);
    fcmToken = json['fcm_token'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['device'] = device.toJson();
    data['fcm_token'] = fcmToken;

    return data;
  }
}
