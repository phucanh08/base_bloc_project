import 'package:base_bloc_project/base_bloc_project.dart';
import 'package:example/commons/route_manager/routes.dart';
import 'package:flutter/widgets.dart';

import 'index.dart';

class Bloc extends BlocBase<Event, List<Ids>> {
  final Model model = Model.init();

  Bloc(BuildContext context) : super([], context) {
    on<Increment>((event, emit) {
      model.count += event.num;
      emit([Ids.count]);
      if(model.count == 10) {
        Get.toNamed(Routes.countPage, arguments: "123456");
      }
    });
    on<Decrease>((event, emit) {
      model.count2--;
      model.count--;
      emit([Ids.count2, Ids.count]);
    });
  }
}
