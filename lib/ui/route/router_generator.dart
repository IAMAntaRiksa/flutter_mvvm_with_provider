import 'package:flutter/material.dart';
import 'package:flutter_caffe_ku/core/models/caffe/caffe_model.dart';
import 'package:flutter_caffe_ku/ui/route/route_list.dart';
import 'package:flutter_caffe_ku/ui/screens/caffe/caffe_cities_screen.dart';
import 'package:flutter_caffe_ku/ui/screens/caffe/caffe_detail_screen.dart';
import 'package:flutter_caffe_ku/ui/screens/caffe/caffe_screen.dart';
import 'package:flutter_caffe_ku/ui/screens/caffe/caffe_search_screen.dart';
import 'package:flutter_caffe_ku/ui/screens/dashboard/dashboard_screen.dart';

class RouterGenerator {
  /// Initializing route
  static Route<dynamic>? generate(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      /// Splash group
      // case routeSplash:
      //   return MaterialPageRoute(
      //     builder: (_) => const SplashScreen(),
      //     settings: const RouteSettings(
      //       arguments: routeSplash,
      //     ),
      //   );

      // Dashboard group
      case routeDashboard:
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
          settings: const RouteSettings(
            arguments: routeDashboard,
          ),
        );

      /// Caffe group
      case routeCaffeSearch:
        return MaterialPageRoute(
          builder: (_) => const CaffeSearchScreen(),
          settings: const RouteSettings(name: routeCaffeSearch),
        );

      case routeCaffe:
        return MaterialPageRoute(
          builder: (_) => const CaffeScreen(),
          settings: const RouteSettings(
            arguments: routeCaffe,
          ),
        );

      case routeCaffeByCities:
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => CaffeCitiesScreen(
              city: args,
            ),
            settings: const RouteSettings(
              arguments: routeCaffeByCities,
            ),
          );
        }
        break;
      case routeCaffeDetail:
        if (args is CaffeModel) {
          return MaterialPageRoute(
            builder: (_) => CaffeDetailScreen(
              id: args,
            ),
            settings: const RouteSettings(
              arguments: routeCaffeDetail,
            ),
          );
        }
        break;
    }
    return null;
  }
}
