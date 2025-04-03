import 'dart:convert';

class MyProfileModel {
  String username;
  String email;
  String? telegramUserId;
  int telegramIsValid;
  String createdAt;
  String? updatedAt;

  MyProfileModel({
    required this.username,
    required this.email,
    this.telegramUserId,
    required this.telegramIsValid,
    required this.createdAt,
    this.updatedAt,
  });

  factory MyProfileModel.fromJson(Map<String, dynamic> map) {
    return MyProfileModel(
      username: map['username'],
      email: map['email'],
      telegramUserId: map['telegram_user_id'],
      telegramIsValid: map['telegram_is_valid'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }
}

MyProfileModel queriesMyProfileModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return MyProfileModel.fromJson(data['data']);
}
