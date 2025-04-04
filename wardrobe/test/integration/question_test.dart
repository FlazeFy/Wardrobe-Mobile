import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' show Client;

void main() {
  const String emuUrl = "http://127.0.0.1:8000";
  Client client = Client();

  test('Question - Test Get Question FAQ', () async {
    // Exec
    final response = await client.get(
      Uri.parse("$emuUrl/api/v1/question/faq"),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    // Test Parameter
    var data = jsonDecode(response.body);
    expect(response.statusCode, 200);

    expect(data.containsKey('status'), true);
    expect(data['status'], 'success');
    expect(data.containsKey('message'), true);
    expect(data.containsKey('data'), true);

    var checkNotNullString = ['question', 'answer', 'created_at'];
    for (var dt in data['data']) {
      for (var col in checkNotNullString) {
        expect(dt.containsKey(col), true);
        expect(dt[col], isNotNull);
        expect(dt[col], isA<String>());
      }
    }
  });
}
