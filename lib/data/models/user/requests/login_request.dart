import 'package:bingo/data/models/devices/device.dart';

class LoginRequest {
  String username;
  String password;
  String fcmToken;
  Device device;

  LoginRequest(
      {required this.username,
      required this.password,
      required this.fcmToken,
      required this.device});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['fcm_token'] = fcmToken;
    data['device'] = device.toJson();
    return data;
  }
}
