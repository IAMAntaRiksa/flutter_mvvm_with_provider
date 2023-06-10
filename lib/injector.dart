import 'package:flutter_caffe_ku/core/utils/navigation/navigation_util.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  /// Registering utils
  locator.registerLazySingleton(() => NavigationUtils());
}
