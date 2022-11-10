import 'package:base_bloc_project/base_bloc_project.dart';
import 'package:flutter/material.dart';
import '../../features/count/index.dart' as count;
import '../../features/home/index.dart' as home;

class Routes {
  static const homePage = '/home';
  static const countPage = '/count';

  static RouteFactory get onGenerateRoute => (RouteSettings settings) {
        switch (settings.name) {
          case homePage:
            return GetPage(
                name: homePage,
                page: const home.View(),
                transition: Transitions.fade,
                transitionDuration: const Duration(seconds: 1));
          case countPage:
            return GetPage(
                name: countPage,
                page: const count.View(),
                transition: Transitions.cupertino,
                transitionDuration: const Duration(seconds: 1));
          default:
            return GetPage.unknownRoute;
        }
      };

  static InitialRouteListFactory get onGenerateInitialRoutes => (homePage) => [
        GetPage(
            name: homePage,
            page: const home.View(),
            transition: Transitions.cupertino,
            transitionDuration: const Duration(milliseconds: 500))
      ];
}
