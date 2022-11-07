import 'package:base_bloc_project/base_bloc_project.dart';

import 'index.dart';

class Bloc extends BlocBase<Event, List<Ids>> {
  final Model model = Model();

  Bloc() : super([]) {
    on<Increment>((event, emit) {
      model.count += event.num;
      emit([Ids.count]);
    });
    on<Decrease>((event, emit) {
      model.count2--;
      model.count--;
      emit([Ids.count2, Ids.count]);
    });
  }
}
