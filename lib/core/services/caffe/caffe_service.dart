import 'package:flutter_caffe_ku/core/data/base_api.dart';
import 'package:flutter_caffe_ku/core/models/api/api_reponse.dart';
import 'package:flutter_caffe_ku/core/models/api/api_result_model.dart';
import 'package:flutter_caffe_ku/core/models/caffe/caffe_model.dart';

class CaffeService {
  BaseAPI api;
  CaffeService(this.api);

  Future<ApiResultList<CaffeModel>> getCaffes() async {
    APIResponse response = await api.get(api.endpoint.getCaffes);
    return ApiResultList<CaffeModel>.fromJson(
      response.data,
      (data) => data.map((e) => CaffeModel.fromJson(e)).toList(),
      field: "restaurants",
    );
  }

  Future<ApiResult<CaffeModel>> getCaffe(String id) async {
    APIResponse response =
        await api.get(api.endpoint.getCaffe.replaceAll(":id", id));

    return ApiResult<CaffeModel>.fromJson(
      response.data,
      (data) => CaffeModel.fromJson(data),
      field: "restaurants",
    );
  }

  Future<ApiResultList<CaffeModel>> searchRestaurants(String keyword) async {
    APIResponse response = await api.get(
      api.endpoint.searchCaffe,
      param: {"q": keyword},
    );

    return ApiResultList<CaffeModel>.fromJson(
      response.data,
      (data) => data.map((e) => CaffeModel.fromJson(e)).toList(),
      field: "restaurants",
    );
  }
}
