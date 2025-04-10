import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wardrobe/design_tokens/global.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/sqlite/init.dart';

class ClothesCommandsService {
  final String emuUrl = "http://10.0.2.2:8000";
  final DatabaseHelper dbHelper = DatabaseHelper();
  Client client = Client();

  Future deleteUsedClothesHistory(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_key');
    final connectivityResult = await (Connectivity().checkConnectivity());
    String backupKey = "used-history-sess";
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    if (connectivityResult != ConnectivityResult.none) {
      final response = await client.delete(
        Uri.parse("$emuUrl/api/v1/clothes/destroy_used/$id"),
        headers: header,
      );

      var responseData = jsonDecode(response.body);
      if ([200, 404, 401, 500].contains(response.statusCode)) {
        await prefs.remove("last-hit-$backupKey");
        await prefs.remove(backupKey);
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
      Get.snackbar("Warning", "Lost connection, try again a few moment letter",
          colorText: whiteColor,
          backgroundColor: darkColor,
          borderColor: primaryColor,
          borderWidth: spaceMini / 2.5);
      isOffline = true;
    }
  }

  Future softDeleteClothes(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_key');
    final connectivityResult = await (Connectivity().checkConnectivity());
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    if (connectivityResult != ConnectivityResult.none) {
      final response = await client.delete(
        Uri.parse("$emuUrl/api/v1/clothes/delete/$id"),
        headers: header,
      );

      var responseData = jsonDecode(response.body);
      if ([200, 404, 401, 500].contains(response.statusCode)) {
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
      Get.snackbar("Warning", "Lost connection, try again a few moment letter",
          colorText: whiteColor,
          backgroundColor: darkColor,
          borderColor: primaryColor,
          borderWidth: spaceMini / 2.5);
      isOffline = true;
    }
  }
}
