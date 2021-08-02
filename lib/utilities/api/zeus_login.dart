import 'dart:convert';

import 'package:flyfi/utilities/api/zeus.dart';
import 'package:http/http.dart' as http;

Future<DeviceToken> zeusLogin(
    String ip, String username, String password) async {
  final response = await http.post(Uri.parse('http://192.168.100.78/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'data': {'username': username, 'password': password}
      }));
  return DeviceToken.fromJson(jsonDecode(response.body)['data']);
}
