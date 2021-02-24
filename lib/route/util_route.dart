import 'package:flutter/material.dart';

import 'navigator.dart';

class UtilRoute {
  static GlobalKey<NavigatorState> navigatorKey;

  // static void registerRoutesMap(List<RouteModel> configuration) =>
  //     utilRouteDelegate.initNameRoutes(configuration);

  static void push(Widget component, {bool replace = false, Object params}) {
    BuildContext context = navigatorKey.currentState.overlay.context;
    UtilNavigator.of(context).push(component, replace: replace, params: params);
  }

  static void pushNamed(String path, {bool replace = false, Object params}) {
    BuildContext context = navigatorKey.currentState.overlay.context;
    UtilNavigator.of(context).pushNamed(path, replace: replace, params: params);
  }

  static bool pop() {
    BuildContext context = navigatorKey.currentState.overlay.context;
    UtilNavigator.of(context).pop();
  }

  static void popUtil(String path) {
    BuildContext context = navigatorKey.currentState.overlay.context;
    UtilNavigator.of(context).popUtil(path);
  }

  static Object get arguments =>
      UtilNavigator.of(navigatorKey.currentState.overlay.context).arguments;
}
