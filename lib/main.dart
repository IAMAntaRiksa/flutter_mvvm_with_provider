import 'package:flutter/material.dart';
import 'package:flutter_caffe_ku/core/utils/navigation/navigation_util.dart';
import 'package:flutter_caffe_ku/core/viewmodels/theme/theme_provider.dart';
import 'package:flutter_caffe_ku/global_providers.dart';
import 'package:flutter_caffe_ku/injector.dart';
import 'package:flutter_caffe_ku/ui/constant/constant.dart';
import 'package:flutter_caffe_ku/ui/constant/themes.dart';
import 'package:flutter_caffe_ku/ui/route/route_list.dart';
import 'package:flutter_caffe_ku/ui/route/router_generator.dart';
import 'package:flutter_caffe_ku/ui/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Setup injector
  await setupLocator();

  /// Registering global providers
  var providers = await GlobalProviders.register();

  /// Initialize screenutil
  await ScreenUtil.ensureScreenSize();

  /// Runing app
  runApp(MyApp(providers: providers));
}

var caffescreen = const DashboardScreen();

class MyApp extends StatelessWidget {
  final List<SingleChildWidget> providers;

  const MyApp({super.key, required this.providers});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer<ThemeProvider>(
        builder: (context, themeProv, _) {
          themeProv.getThemeIsDark();
          var isDarkTheme = themeProv.theme ?? false;
          return MaterialApp(
            title: "Caffe Ku",
            debugShowCheckedModeBanner: false,
            navigatorKey: locator<NavigationUtils>().navigatorKey,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
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
        },
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
