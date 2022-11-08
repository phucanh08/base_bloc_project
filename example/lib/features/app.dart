import 'package:base_bloc_project/base_bloc_project.dart';
import 'package:example/commons/route_manager/routes.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Get.navigationKey,
      routes: Routes.routes(context),
      initialRoute: Routes.homePage
    );
  }
}