import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wardrobe/modules/api/notification/model/command.dart';

class NotificationCommandsService {
  final String emuUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<List<Map<String, dynamic>>> updateFcm(FCMModel data) async {
    final prefs = await SharedPreferences.getInstance();
    const token = '286|L5fqrLCDDCzPRLKngtm2FM9wq1IU2xFZSVAm10yp874a1a85';

    if ((prefs.containsKey('fcm_temp') &&
            prefs.getString('fcm_temp') != data.firebaseFcm) ||
        prefs.containsKey('fcm_temp') == false) {
      final header = {
        'Accept': 'application/json',
        'content-type': 'application/json',
        'Authorization': "Bearer $token",
      };
      final response = await client.put(
        Uri.parse("$emuUrl/api/v1/user/fcm"),
        headers: header,
        body: fcmModelToJson(data),
      );
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 422) {
        prefs.setString('fcm_temp', data.firebaseFcm);
        return [
          {
            "status": responseData["status"],
            "message": responseData["message"],
          }
        ];
      } else {
        return [
          {
            "status": "failed",
            "message": "something wrong. please contact admin"
          }
        ];
      }
    } else {
      return [
        {
          "status": 'error',
          "message": 'FCM still same',
        }
      ];
    }
  }
}
