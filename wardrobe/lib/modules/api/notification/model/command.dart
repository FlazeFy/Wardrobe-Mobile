import 'dart:convert';

class FCMModel {
  String firebaseFcm;

  FCMModel({required this.firebaseFcm});

  Map<dynamic, dynamic> toJson() {
    return {"firebase_fcm_token": firebaseFcm};
  }
}

String fcmModelToJson(FCMModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
