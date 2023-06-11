import 'package:dio/dio.dart';
import 'package:flutter_caffe_ku/core/data/base_api_impl.dart';
import 'package:flutter_caffe_ku/core/models/api/api_reponse.dart';

class BaseAPI implements BaseAPIImpl {
  Dio? _dio;

  /// Initialize constructors
  BaseAPI({Dio? dio}) {
    _dio = dio ?? Dio();
  }

  @override
  Future<APIResponse> get(String url,
      {Map<String, dynamic>? param, bool? useToken}) async {
    try {
      final result = await _dio?.get(
        url,
        options: await getHeaders(useToken: useToken),
        queryParameters: param,
      );

      return _parseResponse(result);
    } on DioException catch (e) {
      return APIResponse.failure(e.response?.statusCode ?? 500);
    }
  }

  @override
  Future<APIResponse> delete(String url,
      {Map<String, dynamic>? param, bool? useToken}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<APIResponse> post(String url,
      {Map<String, dynamic>? param, data, bool? useToken}) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future<APIResponse> put(String url,
      {Map<String, dynamic>? param, data, bool? useToken}) {
    // TODO: implement put
    throw UnimplementedError();
  }

  Future<Options> getHeaders({bool? useToken}) async {
    var header = <String, dynamic>{};
    header['Accept'] = 'application/json';
    header['Content-Type'] = 'application/json';

    if (useToken == true) {
      header['Authorization'] = useToken;
    }

    return Options(
      headers: header,
      sendTimeout: const Duration(seconds: 60), // 60 seconds
      receiveTimeout: const Duration(seconds: 60), // 60 seconds
    );
  }

  Future<APIResponse> _parseResponse(Response? response) async {
    return APIResponse.fromJson({
      'statusCode': response?.statusCode,
      'data': response?.data,
    });
  }
}
