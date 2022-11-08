import 'package:flutter/material.dart';

import '../../features/count/index.dart' as count;
import '../../features/home/index.dart' as home;

class Routes {
  static const homePage = '/home';
  static const countPage = '/count';

  static Map<String, WidgetBuilder> routes(BuildContext context) {
    return {
      homePage: (context) => const home.View(),
      countPage: (context) => const count.View(),
    };
  }
}
