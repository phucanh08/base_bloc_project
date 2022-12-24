import 'package:flutter_bloc/flutter_bloc.dart' hide BlocBase;

class BlocBase<Event, State> extends Bloc<Event, State> {
  BlocBase(super.initialState);
}
