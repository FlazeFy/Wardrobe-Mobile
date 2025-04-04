import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' show Client;

void main() {
  const String emuUrl = "http://127.0.0.1:8000";
  Client client = Client();

  test('Stats - Test Get All Stats', () async {
    // Exec
    final response = await client.get(
      Uri.parse("$emuUrl/api/v1/stats/all"),
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

    var checkNotNullInt = [
      'total_clothes',
      'total_user',
      'total_schedule',
      'total_outfit_decision'
    ];
    for (var col in checkNotNullInt) {
      expect(data['data'][col], isNotNull);
      expect(data['data'][col], isA<int>());
    }
  });

  test('Stats - Test Get Top Feedback', () async {
    // Exec
    final response = await client.get(
      Uri.parse("$emuUrl/api/v1/stats/feedback/top"),
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

    var checkObjectNotNull = [
      'feedback_rate',
      'feedback_body',
      'created_at',
      'username'
    ];

    for (var dt in data['data']) {
      for (var col in checkObjectNotNull) {
        expect(dt.containsKey(col), true);
        expect(dt[col], isNotNull);
      }

      var checkNotNullString = ['feedback_body', 'created_at', 'username'];
      for (var col in checkNotNullString) {
        expect(dt[col], isA<String>());
      }

      expect(
        dt['feedback_rate'],
        isA<int>(),
      );
    }

    expect(data.containsKey('total'), true);
    expect(data.containsKey('average'), true);
    expect(data['total'], isA<int>());
    expect(data['average'], isA<double>());
  });
}
