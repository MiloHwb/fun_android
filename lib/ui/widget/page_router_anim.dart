import 'package:flutter/cupertino.dart';

class NoAnimRouterBuilder extends PageRouteBuilder {
  final Widget page;

  NoAnimRouterBuilder(this.page)
      : super(
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionDuration: Duration(milliseconds: 0),
            transitionsBuilder: (context, animation, secondaryAnimation, child) => child);
}
