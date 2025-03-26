import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wardrobe/modules/api/auth/model/command.dart';
import 'package:wardrobe/modules/helpers/converter.dart';

class AuthCommandsService {
  final String emuUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<List<Map<String, dynamic>>> postLogin(LoginModel data) async {
    final prefs = await SharedPreferences.getInstance();

    final header = {
      'Accept': 'application/json',
      'content-type': 'application/json',
    };
    final response = await client.post(
      Uri.parse("$emuUrl/api/v1/login"),
      headers: header,
      body: loginModelToJson(data),
    );
    var responseData = jsonDecode(response.body);
    if ([200, 422, 401].contains(response.statusCode)) {
      if (response.statusCode == 200) {
        prefs.setString('username', responseData['result']['username']);
        prefs.setString('email', responseData['result']['email']);
        prefs.setString('role_key', responseData['role'].toString());
        prefs.setString('auth_key', responseData['token']);
      }
      return [
        {
          "status": responseData["status"],
          "message": response.statusCode == 200
              ? "Welcome ,${responseData['result']['username']}"
              : getErrorValidation(responseData['result']),
        }
      ];
    } else {
      return [
        {"status": "failed", "message": "something wrong. please contact admin"}
      ];
    }
  }
}
