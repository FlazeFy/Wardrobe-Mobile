import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' show Client;

void main() {
  const String emuUrl = "http://127.0.0.1:8000";
  Client client = Client();
  String token = "";

  test('Auth - Test Post Login', () async {
    // Exec
    var param = {'username': 'flazefy', 'password': 'nopass123'};
    final response = await client.post(
      Uri.parse("$emuUrl/api/v1/login"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(param),
    );

    // Test Parameter
    var data = jsonDecode(response.body);
    expect(response.statusCode, 200);

    expect(data.containsKey('token'), true);
    expect(data.containsKey('role'), true);
    expect(data.containsKey('result'), true);

    var checkObject = ['id', 'username', 'email', 'created_at', 'updated_at'];
    for (var col in checkObject) {
      expect(data['result'].containsKey(col), true);
    }

    var checkNotNullStr = ['id', 'username', 'email', 'created_at'];
    for (var col in checkNotNullStr) {
      expect(data['result'][col], isNotNull);
      expect(data['result'][col], isA<String>());
    }

    token = data['token'];
  });

  test('Auth - Test Get Sign Out', () async {
    // Exec
    final response = await client.get(
      Uri.parse("$emuUrl/api/v1/logout"),
      headers: {'Authorization': "Bearer $token"},
    );

    // Test Parameter
    var data = jsonDecode(response.body);
    expect(response.statusCode, 200);

    expect(data.containsKey('message'), true);
  });
}
