import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wardrobe/design_tokens/global.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/question/model/queries.dart';
import 'package:wardrobe/modules/helpers/generator.dart';

class QuestionQueriesService {
  final String emuUrl = "http://10.0.2.2:8000";
  DateTime now = DateTime.now();
  Client client = Client();

  Future<TopFeedbackResponse?> getTopFeedback() async {
    final prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    String backupKey = "top-feedback-sess";
    DateTime? lastHit;
    lastHit = prefs.containsKey("last-hit-$backupKey")
        ? DateTime.tryParse(prefs.getString("last-hit-$backupKey") ?? '')
        : null;
    final token = prefs.getString('auth_key');
    final header = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    if (!prefs.containsKey(backupKey) ||
        lastHit == null ||
        now.difference(lastHit).inSeconds > statsFetchRestTime) {
      if (connectivityResult == ConnectivityResult.none) {
        if (prefs.containsKey(backupKey)) {
          final data = prefs.getString(backupKey);
          if (data != null) {
            if (!isOffline) {
              Get.snackbar(
                  "Warning", "Lost connection, all data shown are local",
                  colorText: whiteColor,
                  backgroundColor: darkColor,
                  borderColor: primaryColor,
                  borderWidth: spaceMini / 2.5);
              isOffline = true;
            }
            return queriesTopFeedbackResponseFromJson(data);
          } else {
            return null;
          }
        } else {
          return null;
        }
      } else {
        final response = await client.get(
            Uri.parse("$emuUrl/api/v1/stats/feedback/top"),
            headers: header);
        if (response.statusCode == 200) {
          if (isOffline) {
            Get.snackbar(
                "Information", "Welcome back, all data are now realtime",
                colorText: whiteColor,
                backgroundColor: darkColor,
                borderColor: primaryColor,
                borderWidth: spaceMini / 2.5);
            isOffline = false;
          }
          prefs.setString("last-hit-$backupKey", generateTempDataKey());
          prefs.setString(backupKey, response.body);
          return queriesTopFeedbackResponseFromJson(response.body);
        } else if (response.statusCode == 401) {
          return null;
        } else {
          if (prefs.containsKey(backupKey)) {
            final data = prefs.getString(backupKey);
            if (data != null) {
              return queriesTopFeedbackResponseFromJson(response.body);
            } else {
              return null;
            }
          } else {
            return null;
          }
        }
      }
    } else {
      final data = prefs.getString(backupKey);
      if (data != null) {
        return queriesTopFeedbackResponseFromJson(data);
      } else {
        return null;
      }
    }
  }
}
