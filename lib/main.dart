import 'package:flutter/material.dart';
import 'package:flutter_caffe_ku/core/utils/navigation/navigation_util.dart';
import 'package:flutter_caffe_ku/injector.dart';

import 'package:flutter_caffe_ku/ui/constant/constant.dart';
import 'package:flutter_caffe_ku/ui/constant/themes.dart';
import 'package:flutter_caffe_ku/ui/route/route_list.dart';
import 'package:flutter_caffe_ku/ui/route/router_generator.dart';
import 'package:flutter_caffe_ku/ui/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  /// Setup injector
  await setupLocator();

  /// Initialize screenutil
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

var caffescreen = const DashboardScreen();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Caffe Ku",
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<NavigationUtils>().navigatorKey,
      theme: lightTheme,
      themeMode: ThemeMode.light,
      initialRoute: routeDashboard,
      onGenerateRoute: RouterGenerator.generate,
      builder: (ctx, child) {
        setupScreenUtil(ctx);
        return MediaQuery(
          data: MediaQuery.of(ctx).copyWith(textScaleFactor: 1.0),
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: child!,
          ),
        );
      },
    );
  }
}

class MyBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
