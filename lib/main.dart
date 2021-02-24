import 'package:aoli/route/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'pages/splash.dart';
import 'route/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 初始化downloader下载库
  await FlutterDownloader.initialize(debug: true);
  // PermissionStatus status = await Permission.notification.status;
  // print('status $status');
  // await Permission.notification.request();
  runApp(AoliApp());
}

class AoliApp extends StatefulWidget {
  @override
  _AoliAppState createState() => _AoliAppState();
}

class _AoliAppState extends State<AoliApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 667),
        allowFontScaling: false,
        builder: () => MaterialApp(
            // By giving the navigatorKey parameter as the same parameter we use in
            // our internal navigator the default pop action will pop on our Navigator.
            navigatorKey: _navigatorKey,
            // This just satisfies the asserts inside of MaterialApp. This is not
            // actually called because it is assigned to a Navigator widget we don't use.
            onGenerateRoute: (_) => null,
            // This is called with `child` as the Navigator. We can simply ignore
            // this parameter and give our own Navigator (inside AppNavigator) with the
            // same key to override the default one.
            builder: (BuildContext context, _ /*Widget child*/) =>
                UtilNavigator(
                  navigatorKey: _navigatorKey,
                  initialPage: Splash(),
                  registerRoutes: routeConfig,
                )));
  }
}
