import 'package:aoli/pages/login/login_page.dart';
import 'package:aoli/pages/login/register_page.dart';

import 'route_page.dart';

List<RoutePage> routeConfig = [
  RoutePage(name: 'login', child: LoginPage()),
  RoutePage(name: 'register', child: RegisterPage()),
];
