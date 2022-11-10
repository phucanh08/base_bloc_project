import 'package:base_bloc_project/base_bloc_project.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class GetPage extends PageRouteBuilder {
  final String name;
  final Widget page;
  final Transitions transition;
  final Curve curve;
  final Alignment? alignment;

  GetPage({
    required this.name,
    required this.page,
    this.transition = Transitions.rightToLeftWithFade,
    Duration? transitionDuration,
    Duration? reverseTransitionDuration,
    this.curve = Curves.linear,
    this.alignment,
  }) : super(
          transitionDuration: transitionDuration ?? const Duration(milliseconds: 300),
          reverseTransitionDuration: reverseTransitionDuration ?? const Duration(milliseconds: 300),
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              page,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return buildPageTransitions(
              context,
              animation,
              secondaryAnimation,
              child,
              curve,
              alignment,
              transition,
            );
          },
        );

  static get unknownRoute => GetPage(
        name: 'unknownRoute',
        page: const Scaffold(
          body: Center(child: Text('Route not found')),
        ),
      );

  Route get build => MaterialPageRoute(builder: (_) => page);

  static Widget buildPageTransitions<T>(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
    Curve curve,
    Alignment? alignment,
    Transitions transition,
  ) {
    animation = CurvedAnimation(parent: animation, curve: curve);

    switch (transition) {
      case Transitions.leftToRight:
        return SlideLeftTransition().buildTransitions(
            context, curve, alignment, animation, secondaryAnimation, child);

      case Transitions.downToUp:
        return SlideDownTransition().buildTransitions(
            context, curve, alignment, animation, secondaryAnimation, child);

      case Transitions.upToDown:
        return SlideTopTransition().buildTransitions(
            context, curve, alignment, animation, secondaryAnimation, child);

      case Transitions.noTransition:
        return child;

      case Transitions.rightToLeft:
        return SlideRightTransition().buildTransitions(
            context, curve, alignment, animation, secondaryAnimation, child);

      case Transitions.zoom:
        return ZoomInTransition().buildTransitions(
            context, curve, alignment, animation, secondaryAnimation, child);

      case Transitions.fadeIn:
        return FadeInTransition().buildTransitions(
            context, curve, alignment, animation, secondaryAnimation, child);

      case Transitions.rightToLeftWithFade:
        return RightToLeftFadeTransition().buildTransitions(
            context, curve, alignment, animation, secondaryAnimation, child);

      case Transitions.leftToRightWithFade:
        return LeftToRightFadeTransition().buildTransitions(
            context, curve, alignment, animation, secondaryAnimation, child);

      case Transitions.cupertino:
        return CupertinoPageTransition(
            primaryRouteAnimation: animation,
            secondaryRouteAnimation: secondaryAnimation,
            linearTransition: false,
            child: child);

      case Transitions.size:
        return SizeTransitions().buildTransitions(
            context, curve, alignment, animation, secondaryAnimation, child);

      case Transitions.fade:
        return const FadeUpwardsPageTransitionsBuilder().buildTransitions(
            null, context, animation, secondaryAnimation, child);

      case Transitions.topLevel:
        return const ZoomPageTransitionsBuilder().buildTransitions(
            null, context, animation, secondaryAnimation, child);

      case Transitions.circularReveal:
        return CircularRevealTransition().buildTransitions(
            context, curve, alignment, animation, secondaryAnimation, child);

      case Transitions.native:
      default:
        return child;
      // return const PageTransitionsTheme().buildTransitions(
      //     route, context, iosAnimation, secondaryAnimation, child);
    }
  }
}
