import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide BlocBase;

class BlocBase<Event, State> extends Bloc<Event, State> {
  final BuildContext context;
  BlocBase(super.initialState, this.context);
}
