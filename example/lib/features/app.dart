import 'package:example/commons/route_manager/routes.dart';
import 'package:flutter/material.dart';
import 'count/index.dart' as count;


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const count.Page(),
      routes: routes.routes(context),
    );
  }
}

