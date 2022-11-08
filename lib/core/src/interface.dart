export '../../navigation/navigation.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'log.dart';
import 'smart_management.dart';

abstract class Interface {
  SmartManagement smartManagement = SmartManagement.full;
  bool isLogEnable = kDebugMode;
  LogWriterCallback log = defaultLogWriterCallback;
  GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
}
