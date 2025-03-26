import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

class AuthQueriesService {
  final String emuUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<List<Map<String, dynamic>>> getSignOut() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('auth_key') ?? "";

    final header = {
      'Accept': 'application/json',
      'content-type': 'application/json',
      'Authorization': "Bearer $token",
    };
    final response = await client.get(
      Uri.parse("$emuUrl/api/v1/logout"),
      headers: header,
    );
    var responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      prefs.clear();

      return [
        {
          "status": responseData["status"],
          "message": responseData['message'],
        }
      ];
    } else {
      return [
        {"status": "failed", "message": "something wrong. please contact admin"}
      ];
    }
  }
}
