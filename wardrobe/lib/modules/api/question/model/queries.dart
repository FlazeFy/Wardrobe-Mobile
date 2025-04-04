import 'dart:convert';

class TopFeedbackModel {
  int feedbackRate;
  String feedbackBody;
  String createdAt;
  String username;

  TopFeedbackModel({
    required this.feedbackRate,
    required this.feedbackBody,
    required this.createdAt,
    required this.username,
  });

  factory TopFeedbackModel.fromJson(Map<String, dynamic> map) {
    return TopFeedbackModel(
      feedbackRate: map['feedback_rate'],
      feedbackBody: map['feedback_body'],
      createdAt: map['created_at'],
      username: map['username'],
    );
  }
}

class TopFeedbackResponse {
  final List<TopFeedbackModel> data;
  final int total;
  final double average;

  TopFeedbackResponse({
    required this.data,
    required this.total,
    required this.average,
  });

  factory TopFeedbackResponse.fromJson(Map<String, dynamic> json) {
    return TopFeedbackResponse(
      data: List<TopFeedbackModel>.from(
        json['data'].map((item) => TopFeedbackModel.fromJson(item)),
      ),
      total: json['total'],
      average: json['average'].toDouble(),
    );
  }
}

TopFeedbackResponse queriesTopFeedbackResponseFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return TopFeedbackResponse.fromJson(data);
}
