import 'package:flutter_caffe_ku/core/models/api/api_result_model.dart';

base class MenuItemModel extends Serializable {
  final String name;

  MenuItemModel({required this.name});

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      name: json['name'] ?? "",
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}
