import 'package:flutter_caffe_ku/core/viewmodels/connection/connection_provider.dart';
import 'package:flutter_caffe_ku/core/viewmodels/favorite/favorite_provider.dart';
import 'package:flutter_caffe_ku/core/viewmodels/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class GlobalProviders {
  /// Register your provider here
  static Future<dynamic> register() async {
    return [
      ChangeNotifierProvider(create: (context) => FavoriteProvider()),
      ChangeNotifierProvider(create: (context) => ConnectionProvider()),
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ];
  }
}
