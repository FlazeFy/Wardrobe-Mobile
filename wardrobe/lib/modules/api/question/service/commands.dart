import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/question/model/commands.dart';
import 'package:wardrobe/modules/sqlite/init.dart';

class QuestionCommandsService {
  final String emuUrl = "http://10.0.2.2:8000";
  final DatabaseHelper dbHelper = DatabaseHelper();
  Client client = Client();

  Future<List<Map<String, dynamic>>> postAskQuestion(
      AskQuestionModel data) async {
    final prefs = await SharedPreferences.getInstance();
    // final token = prefs.getString('token_key');
    final connectivityResult = await (Connectivity().checkConnectivity());
    const token = '286|L5fqrLCDDCzPRLKngtm2FM9wq1IU2xFZSVAm10yp874a1a85';

    if (connectivityResult != ConnectivityResult.none) {
      await dbHelper.insertQuestion(question: data.question);

      Get.snackbar("Warning",
          "Lost connection, the data temprorary store in your local device",
          colorText: whiteColor,
          backgroundColor: darkColor,
          borderColor: primaryColor,
          borderWidth: spaceMini / 2.5);

      return [
        {
          "status": 200,
          "message": "Question created",
        }
      ];
    } else {
      final header = {
        'Accept': 'application/json',
        'content-type': 'application/json',
        'Authorization': "Bearer $token",
      };
      final response = await client.post(
        Uri.parse("$emuUrl/api/v1/question"),
        headers: header,
        body: askQuestionModelToJson(data),
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

  Future<void> syncQuestions() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    const token = '286|L5fqrLCDDCzPRLKngtm2FM9wq1IU2xFZSVAm10yp874a1a85';

    if (connectivityResult != ConnectivityResult.none) {
      List<AskQuestionModel> tempQuestion =
          await dbHelper.getUnsyncedQuestion();
      int successSync = 0;

      for (var dt in tempQuestion) {
        final response = await client.post(
          Uri.parse("$emuUrl/api/v1/question"),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': "Bearer $token",
          },
          body: jsonEncode({"question": dt.question}),
        );

        if (response.statusCode == 201 && dt.id != null) {
          successSync++;
          await dbHelper.deleteQuestion(dt.id);
        }
      }

      String status = successSync == 0 ? "Failed" : "Success";
      String message = successSync == tempQuestion.length
          ? "All stored questions have been synced!"
          : successSync < tempQuestion.length && successSync > 0
              ? "Some questions are not been synced!"
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
