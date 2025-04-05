import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/feedback/model/commands.dart';
import 'package:wardrobe/modules/sqlite/init.dart';

class FeedbackCommandsService {
  final String emuUrl = "http://10.0.2.2:8000";
  final DatabaseHelper dbHelper = DatabaseHelper();
  Client client = Client();

  Future<List<Map<String, dynamic>>> postFeedback(FeedbackModel data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_key');
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      await dbHelper.insertFeedback(
          feedbackBody: data.feedbackBody, feedbackRate: data.feedbackRate);

      Get.snackbar("Warning",
          "Lost connection, the data temprorary store in your local device",
          colorText: whiteColor,
          backgroundColor: darkColor,
          borderColor: primaryColor,
          borderWidth: spaceMini / 2.5);

      return [
        {
          "status": 201,
          "message": "Feedback created",
        }
      ];
    } else {
      final header = {
        'Accept': 'application/json',
        'content-type': 'application/json',
        'Authorization': "Bearer $token",
      };
      final response = await client.post(
        Uri.parse("$emuUrl/api/v1/feedback"),
        headers: header,
        body: feedbackModelToJson(data),
      );

      var responseData = jsonDecode(response.body);
      if ([201, 404, 401, 500].contains(response.statusCode)) {
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
    }
  }

  Future<void> syncFeedbacks() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_key');
    if (connectivityResult != ConnectivityResult.none) {
      List<FeedbackModel> tempFeedback = await dbHelper.getUnsyncedFeedback();
      int successSync = 0;

      for (var dt in tempFeedback) {
        final response = await client.post(
          Uri.parse("$emuUrl/api/v1/feedback"),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': "Bearer $token",
          },
          body: jsonEncode({
            "feedback_body": dt.feedbackBody,
            "feedback_rate": dt.feedbackRate
          }),
        );

        if (response.statusCode == 201 && dt.id != null) {
          successSync++;
          await dbHelper.deleteFeedback(dt.id);
        }
      }

      String status = successSync == 0 ? "Failed" : "Success";
      String message = successSync == tempFeedback.length
          ? "All stored feedbacks have been synced!"
          : successSync < tempFeedback.length && successSync > 0
              ? "Some feedbacks are not been synced!"
              : "Failed to sync all question";

      Get.snackbar(
        status,
        message,
        colorText: whiteColor,
        backgroundColor: primaryColor,
      );
    } else {
      Get.snackbar(
        "No Internet",
        "Please check your connection and try again.",
        colorText: whiteColor,
        backgroundColor: darkColor,
      );
    }
  }
}
