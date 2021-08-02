import 'package:flyfi/utilities/api/zeus_login.dart';

class Zeus {
  String deviceIp = '';
  String deviceUsername = '';
  String devicePassword = '';
  String deviceToken = '';

  Future<DeviceToken> login() {
    var login = zeusLogin(deviceIp, deviceUsername, devicePassword);
    return login;
  }
}

dashInfos() {}

class DeviceToken {
  final String token;

  DeviceToken({
    required this.token,
  });

  factory DeviceToken.fromJson(Map<String, dynamic> json) {
    return DeviceToken(
      token: json['token'] == null ? '' : json['token'],
    );
  }
}
