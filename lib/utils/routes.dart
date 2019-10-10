import 'package:flutter/material.dart';

class FadePageRoute<T> extends MaterialPageRoute {
  FadePageRoute(
      {@required WidgetBuilder builder, @required RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // TODO: implement buildTransitions
    if (settings.isInitialRoute) {
      return child;
    }
    return new FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
