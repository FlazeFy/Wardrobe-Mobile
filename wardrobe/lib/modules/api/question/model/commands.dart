import 'dart:convert';

class AskQuestionModel {
  String question;
  String? createdAt;
  int? id;

  AskQuestionModel({required this.question, this.createdAt, this.id});

  Map<dynamic, dynamic> toJson() {
    return {"question": question, "created_at": createdAt, "id": id};
  }
}

String askQuestionModelToJson(AskQuestionModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
