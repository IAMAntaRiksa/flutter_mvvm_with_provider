import 'package:flutter_caffe_ku/core/models/api/api_result_model.dart';

base class CategoryModel extends Serializable {
  final String name;

  CategoryModel({
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
