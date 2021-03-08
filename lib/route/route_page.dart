import 'package:flutter/material.dart';

class RoutePage<T> extends Page<T> {
  RoutePage(
      {@required this.child,
      this.maintainState = true,
      this.fullscreenDialog = false,
      this.name,
      this.enterBefore})
      : assert(child != null),
        assert(maintainState != null),
        assert(fullscreenDialog != null),
        super(
          name: name,
        );
  final String name;

  /// The content to be shown in the [Route] created by this page.
  final Widget child;

  /// {@macro flutter.widgets.modalRoute.maintainState}
  final bool maintainState;

  /// {@macro flutter.widgets.pageRoute.fullscreenDialog}
  final bool fullscreenDialog;

  final Future Function() enterBefore;

  @override
  Route<T> createRoute(BuildContext context) {
    return _PageBasedRoutePageRoute<T>(page: this);

    // return transitionType == null
    //     ? MaterialPageRoute(
    //         settings: this,
    //         builder: (BuildContext context) => child,
    //       )
    //     : PageTransition(settings: this, type: transitionType, child: child);
  }
}

class _PageBasedRoutePageRoute<T> extends PageRoute<T>
    with MaterialRouteTransitionMixin<T> {
  _PageBasedRoutePageRoute({
    @required RoutePage<T> page,
  })  : assert(page != null),
        super(settings: page);

  RoutePage<T> get _page => settings as RoutePage<T>;

  @override
  Widget buildContent(BuildContext context) {
    return _page.child;
  }

  @override
  bool get maintainState => _page.maintainState;

  @override
  bool get fullscreenDialog => _page.fullscreenDialog;

  @override
  String get debugLabel => '${super.debugLabel}(${_page.name})';
}
