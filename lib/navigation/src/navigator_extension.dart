import 'package:base_bloc_project/core/core.dart';
import 'package:flutter/widgets.dart';

extension NavigatorExtension on Interface {
  Future<T?> toNamed<T extends Object?>(String name,
      {Object? arguments}) async {
    return navigationKey.currentState?.pushNamed<T>(name, arguments: arguments);
  }

  Future<R?> offNamed<T, R>(String name,
      {T? result, R? arguments}) async {
    back<T>(result);
    return toNamed<R>(name, arguments: arguments);
  }

  Future<T?> offNamedUtil<T extends Object?>(
    String newRouteName,
    RoutePredicate predicate, {
    Object? arguments,
  }) async {
    return navigationKey.currentState?.pushNamedAndRemoveUntil<T>(
        newRouteName, predicate,
        arguments: arguments);
  }

  Future<T?> offAllNamed<T extends Object?>(
    String newRouteName, {
    Object? arguments,
  }) async {
    return offNamedUtil<T>( newRouteName, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  void back<T extends Object?>([T? result]) {
    return navigationKey.currentState?.pop(result);
  }

  void backUtil<T extends Object?>(String route) {
    return navigationKey.currentState?.popUntil(ModalRoute.withName(route));
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
