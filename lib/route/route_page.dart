import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RoutePage<T> extends Page<T> {
  RoutePage(
      {@required this.child,
      this.maintainState = true,
      this.fullscreenDialog = false,
      this.name,
      this.transitionType,
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

  PageTransitionType transitionType;

  @override
  Route<T> createRoute(BuildContext context) {
    return transitionType == null
        ? MaterialPageRoute(
            settings: this,
            builder: (BuildContext context) => child,
          )
        : PageTransition(settings: this, type: transitionType, child: child);
  }
}
