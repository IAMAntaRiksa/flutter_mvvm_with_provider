import 'package:flutter_caffe_ku/core/models/api/api_result_model.dart';

base class ReviewModel extends Serializable {
  final String name;
  final String review;
  final String date;
  ReviewModel({
    required this.name,
    required this.review,
    required this.date,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      name: json['name'] ?? "",
      review: json['review'] ?? "",
      date: json['date'] ?? "",
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "review": review,
      "date": date,
    };
  }
}
