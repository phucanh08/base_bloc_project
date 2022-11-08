import 'package:flutter/material.dart';

import '../../features/count/index.dart' as count;

final Routes routes = Routes();

class Routes {
  BuildContext? context;
  static const home = '/home';

  Map<String, WidgetBuilder> routes(BuildContext context) {
    this.context = context;
    return {
      home: (context) => const count.Page(),
    };
  }
}


extension RouteManager on Routes {
  Future<T?>? to<T>(dynamic page) {
    assert(context != null);

    Navigator.of(context!).push(MaterialPageRoute(builder: (context) => page));
  }

  _route({required String name, required PageBuilder page, Transition transition = Transition.fade}) {
   return {name: _createRoute(page, transition)};
  }
}

Route _createRoute(page, Transition transition) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      final tween = Tween(begin: begin, end: end);
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );
      return SlideTransition(
        position:
        tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}


enum Transition {
  fade,
  fadeIn,
  rightToLeft,
  leftToRight,
  upToDown,
  downToUp,
  rightToLeftWithFade,
  leftToRightWithFade,
  zoom,
  topLevel,
  noTransition,
  cupertino,
  cupertinoDialog,
  size,
  circularReveal,
  native,
}

typedef PageBuilder = Widget Function();
