import 'package:aoli/pages/main_page.dart';
import 'package:aoli/pages/login/login_page.dart';
import 'package:aoli/pages/login/register_page.dart';
import 'package:page_transition/page_transition.dart';

import 'route_page.dart';

List<RoutePage> routeConfig = [
  RoutePage(name: 'login', child: LoginPage()),
  RoutePage(
      name: 'register',
      child: RegisterPage(),
      transitionType: PageTransitionType.scale),
  RoutePage(name: 'main', child: MainPage())
];
