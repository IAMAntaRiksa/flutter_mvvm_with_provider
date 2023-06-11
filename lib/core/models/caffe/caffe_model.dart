import 'package:flutter_caffe_ku/core/models/api/api_result_model.dart';
import 'package:flutter_caffe_ku/core/models/category/category_model.dart';
import 'package:flutter_caffe_ku/core/models/menu/menu_model.dart';
import 'package:flutter_caffe_ku/core/models/review/reveiw_model.dart';

base class CaffeModel extends Serializable {
  final String id;
  final String name;
  final String description;
  final String city;
  final String? address;
  final double rating;
  final CaffeImageModel? image;
  List<CategoryModel>? categories;
  final MenuModel? menus;
  List<ReviewModel>? reviews;
  bool isFavorite;

  CaffeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    this.address,
    required this.rating,
    this.image,
    this.categories,
    this.menus,
    this.reviews,
    this.isFavorite = false,
  });

  factory CaffeModel.fromJson(Map<String, dynamic> json) {
    return CaffeModel(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      city: json['city'] ?? "",
      address: json['address'] ?? "",
      rating:
          json['rating'] != null ? double.tryParse(json['rating']) ?? 0.0 : 0.0,
      image: json['pictureId'] != null
          ? CaffeImageModel.fromJson(json['pictureId'])
          : null,
      categories: json['categories'] != null
          ? List<CategoryModel>.from(
              json['categories'].map((e) => CategoryModel.fromJson(e)).toList())
          : [],
      menus: json['menus'] != null ? MenuModel.fromJson(json['menus']) : null,
      reviews: json['customerReviews'] != null
          ? List<ReviewModel>.from(
              json['customerReviews'].map((x) => ReviewModel.fromJson(x)))
          : [],
    );
  }

  factory CaffeModel.failure() =>
      CaffeModel(id: "", name: "", description: "", city: "", rating: 0.0);

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "city": city,
      "rating": rating,
      "menus": menus?.toJson(),
      "image": image?.toJson(),
      "categories": categories?.map((x) => x.toJson()).toList(),
      "customerReviews": reviews?.map((x) => x.toJson()).toList()
    };
  }
}

base class CaffeImageModel extends Serializable {
  final String smallResolution;
  final String? mediumResolution;
  final String? largeResolution;

  CaffeImageModel({
    required this.smallResolution,
    this.mediumResolution,
    this.largeResolution,
  });

  factory CaffeImageModel.fromJson(String pictureId) {
    return CaffeImageModel(
      smallResolution:
          "https://restaurant-api.dicoding.dev/images/small/$pictureId",
      mediumResolution:
          "https://restaurant-api.dicoding.dev/images/medium/$pictureId",
      largeResolution:
          "https://restaurant-api.dicoding.dev/images/large/$pictureId",
    );
  }

  @override
  @override
  Map<String, dynamic> toJson() {
    return {
      "smallResolution": smallResolution,
      "mediumResolution": mediumResolution,
      "largeResolution": largeResolution,
    };
  }
}
