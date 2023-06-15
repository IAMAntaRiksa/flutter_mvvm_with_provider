import 'package:flutter_caffe_ku/core/viewmodels/caffe/caffe_provider.dart';
import 'package:provider/provider.dart';

class GlobalProviders {
  /// Register your provider here
  static Future<dynamic> register() async => [
        ChangeNotifierProvider(create: (context) => CaffeProvider()),
      ];
}
