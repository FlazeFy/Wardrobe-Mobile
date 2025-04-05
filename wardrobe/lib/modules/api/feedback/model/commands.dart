import 'dart:convert';

class FeedbackModel {
  String? createdAt;
  int? id;
  String feedbackBody;
  int feedbackRate;

  FeedbackModel(
      {this.id,
      required this.feedbackBody,
      required this.feedbackRate,
      this.createdAt});

  Map<dynamic, dynamic> toJson() {
    return {
      "id": id,
      "feedback_body": feedbackBody,
      "feedback_rate": feedbackRate,
      "created_at": createdAt,
    };
  }
}

String feedbackModelToJson(FeedbackModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
