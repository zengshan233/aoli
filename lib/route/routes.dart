import 'package:aoli/pages/main_page.dart';
import 'package:aoli/pages/login/login_page.dart';
import 'package:aoli/pages/login/register_page.dart';
import 'package:aoli/pages/research/research_detail_page.dart';
import 'package:aoli/pages/settings/setting_account.dart';
import 'package:aoli/pages/settings/settings_page.dart';

import 'route_page.dart';

List<RoutePage> routeConfig = [
  RoutePage(name: 'login', child: LoginPage()),
  RoutePage(name: 'register', child: RegisterPage()),
  RoutePage(name: 'main', child: MainPage()),
  RoutePage(name: 'settings', child: SettingsPage()),
  RoutePage(name: 'settings/account', child: SettingsAccount()),
  RoutePage(name: 'researchDetail', child: ResearchDetailPage())
];
