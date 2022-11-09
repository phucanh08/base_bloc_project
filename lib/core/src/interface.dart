import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'log.dart';

abstract class Interface {
  bool isLogEnable = kDebugMode;
  LogWriterCallback log = defaultLogWriterCallback;
  GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
}
