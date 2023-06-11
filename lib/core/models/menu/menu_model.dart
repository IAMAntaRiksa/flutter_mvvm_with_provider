import 'package:flutter_caffe_ku/core/models/api/api_result_model.dart';
import 'package:flutter_caffe_ku/core/models/menu/menu_item_model.dart';

base class MenuModel extends Serializable {
  final List<MenuItemModel> foods;
  final List<MenuItemModel> drinks;

  MenuModel({
    required this.foods,
    required this.drinks,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      foods: (json['foods'] as List)
          .map((e) => MenuItemModel.fromJson(e))
          .toList(),
      drinks: (json['drinks'] as List)
          .map((e) => MenuItemModel.fromJson(e))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'foods': foods,
      'drinks': drinks,
    };
  }
}
