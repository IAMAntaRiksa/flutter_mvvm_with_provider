import 'package:flutter_caffe_ku/core/data/api.dart';
import 'package:flutter_caffe_ku/core/data/base_api.dart';
import 'package:flutter_caffe_ku/core/services/caffe/caffe_service.dart';
import 'package:flutter_caffe_ku/core/utils/favorite/favorite_utils.dart';
import 'package:flutter_caffe_ku/core/utils/navigation/navigation_util.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  /// Registering utils
  locator.registerLazySingleton(() => NavigationUtils());
  locator.registerLazySingleton(() => FavoriteUtils());

  /// Registering Api
  locator.registerSingleton(Api());
  locator.registerSingleton(BaseAPI());

  // Registering Services
  locator.registerLazySingleton(() => CaffeService(locator<BaseAPI>()));
}
