import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'route_page.dart';
import 'util_route.dart';

const transitionDuration = Duration(milliseconds: 400);

class UtilNavigator extends StatefulWidget {
  const UtilNavigator(
      {Key key,
      @required this.navigatorKey,
      @required this.initialPage,
      this.registerRoutes,
      this.transitionType})
      : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;
  final Widget initialPage;
  final List<RoutePage> registerRoutes;
  final PageTransitionType transitionType;

  static UtilNavigatorState of(BuildContext context) {
    return context.findAncestorStateOfType<UtilNavigatorState>();
  }

  @override
  UtilNavigatorState createState() => UtilNavigatorState();
}

class UtilNavigatorState extends State<UtilNavigator> {
  final List<RoutePage> _routeStack = [];

  List<RoutePage> _registerRoutes = [];

  bool backAnimationOff = false;

  bool _backForbid = false;

  Map<String, Object> _arguments = {};

  Object get arguments => _arguments[_routeStack.last.name];

  @override
  void initState() {
    super.initState();
    assert(widget.initialPage != null);
    UtilRoute.navigatorKey = widget.navigatorKey;
    _routeStack.add(RoutePage(
      name: '/',
      child: widget.initialPage,
    ));
    initNameRoutes(routes: widget.registerRoutes);
  }

  void initNameRoutes({List<RoutePage> routes = const []}) {
    if (routes.isNotEmpty) {
      routes.forEach((e) {
        if (e.transitionType == null) e.transitionType = widget.transitionType;
      });
    }
    _registerRoutes = routes;
  }

  void push(Widget component, {bool replace = false, Object params}) {
    print('start push');
    String widgetName = '${component.runtimeType}';
    _arguments[widgetName] = params;

    RoutePage nextPage = RoutePage(
        name: widgetName,
        child: component,
        transitionType: widget.transitionType);
    setState(() => _routeStack.add(nextPage));
    if (replace && _routeStack.length > 1) _deleteAncestorRoute();
  }

  void pushNamed(String path, {bool replace = false, Object params}) {
    List<String> registerNames = _registerRoutes.map((e) => e.name).toList();
    int registeredIdx = registerNames.indexOf(path);
    if (registeredIdx > -1) {
      _arguments[path] = params;
      Page pushPage = _registerRoutes[registeredIdx];
      setState(() => _routeStack.add(pushPage));
      if (replace && _routeStack.length > 1) _deleteAncestorRoute();
    } else {
      throw 'path:$path is not registered！';
    }
  }

  Future _deleteAncestorRoute() async {
    _backForbid = true;
    setState(() => backAnimationOff = true);
    await Future.delayed(transitionDuration);
    remove(_routeStack[_routeStack.length - 2]);
    await Future.delayed(Duration(milliseconds: 10));
    _backForbid = false;
    setState(() => backAnimationOff = false);
    print('push  down');
  }

  bool pop() {
    if (_routeStack.isNotEmpty) {
      setState(() => _routeStack.removeLast());
      return true;
    }
    return false;
  }

  void popUtil(String path) {
    int routeIdx = _routeStack.lastIndexWhere((r) => r.name == path);
    if (routeIdx > -1) {
      setState(() => _routeStack.removeRange(routeIdx + 1, _routeStack.length));
    }
  }

  bool add(Page page, Page afterPage) {
    final index = _routeStack.indexOf(afterPage);
    if (index == -1) {
      return false;
    }
    setState(() => _routeStack.insert(index + 1, page));
    return true;
  }

  bool remove(Page page) {
    final index = _routeStack.indexOf(page);
    if (index == -1) {
      return false;
    }
    setState(() => _routeStack.remove(page));
    return true;
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    if (!_backForbid) {
      remove(route.settings as Page);
      return route.didPop(result);
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,
      onPopPage: _onPopPage,
      pages: List.of(_routeStack),
      transitionDelegate: NoAnimationTransitionDelegate(
          forwardAnimationOff: false, backAnimationOff: backAnimationOff),
    );
  }
}

class NoAnimationTransitionDelegate extends TransitionDelegate<void> {
  final bool forwardAnimationOff;
  final bool backAnimationOff;
  NoAnimationTransitionDelegate(
      {this.forwardAnimationOff = false, this.backAnimationOff = false});

  @override
  Iterable<RouteTransitionRecord> resolve({
    List<RouteTransitionRecord> newPageRouteHistory,
    Map<RouteTransitionRecord, RouteTransitionRecord>
        locationToExitingPageRoute,
    Map<RouteTransitionRecord, List<RouteTransitionRecord>>
        pageRouteToPagelessRoutes,
  }) {
    final results = <RouteTransitionRecord>[];

    for (final pageRoute in newPageRouteHistory) {
      if (pageRoute.isWaitingForEnteringDecision) {
        forwardAnimationOff ? pageRoute.markForAdd() : pageRoute.markForPush();
      }
      results.add(pageRoute);
    }

    for (final exitingPageRoute in locationToExitingPageRoute.values) {
      if (exitingPageRoute.isWaitingForExitingDecision) {
        backAnimationOff
            ? exitingPageRoute.markForRemove()
            : exitingPageRoute.markForPop();
        final pagelessRoutes = pageRouteToPagelessRoutes[exitingPageRoute];
        if (pagelessRoutes != null) {
          for (final pagelessRoute in pagelessRoutes) {
            backAnimationOff
                ? pagelessRoute.markForRemove()
                : pagelessRoute.markForPop();
          }
        }
      }

      results.add(exitingPageRoute);
    }
    return results;
  }
}
