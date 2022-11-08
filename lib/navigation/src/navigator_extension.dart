import 'package:base_bloc_project/core/core.dart';
import 'package:flutter/widgets.dart';

extension NavigatorExtension on Interface {
  Future<T?> toNamed<T extends Object?>(String name,
      {Object? arguments}) async {
    return navigationKey.currentState
        ?.pushNamed<T>(name, arguments: arguments);
  }

  void back<T extends Object?>([T? result]) {
    return navigationKey.currentState?.pop(result);
  }

  void backUtil<T extends Object?>(String route) {
    return navigationKey.currentState
        ?.popUntil(ModalRoute.withName(route));
  }

  RouteSettings? get settings {
    final BuildContext? context = navigationKey.currentContext;
    if (context == null) {
      return null;
    } else {
      return ModalRoute.of(context)?.settings;
    }
  }

  dynamic get argument => settings?.arguments;
}