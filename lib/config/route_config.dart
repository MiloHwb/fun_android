import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_android/ui/page/splash.dart';
import 'package:fun_android/ui/widget/page_router_anim.dart';

class RouteName {
  static const String splash = 'splash';
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return NoAnimRouterBuilder(SplashPage());
      default:
        return CupertinoPageRoute(builder: (context) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
