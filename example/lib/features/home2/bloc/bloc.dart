import 'package:example/commons/route_manager/routes.dart';

import '../index.dart';

enum Ids {
  count,
  count2;
  ValueKey<Ids> get key => ValueKey(this);
}

class Bloc extends BlocBase<Event, State>{
  Bloc() : super(const State()) {
    on<Increment>((event, emit) {
      final count = state.count + event.num;
      emit(state.copyWith(listIdUpdate: [Ids.count.key], count: count));
      if (count == 10) {
        Get.toNamed(Routes.countPage, arguments: "123456");
      }
    });
    on<Decrease>((event, emit) {
      final count = state.count - 1;
      final count2 = state.count2 - 1;
      emit(state.copyWith(
        listIdUpdate: [Ids.count2.key, Ids.count.key],
        count: count,
        count2: count2,
      ));
      Get.back();
    });
  }
}
