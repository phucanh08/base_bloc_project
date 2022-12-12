import 'package:base_bloc_project/base_bloc_project.dart';
import 'package:example/commons/route_manager/routes.dart';
import 'package:flutter/widgets.dart';

import 'index.dart';

class Bloc extends BlocBase<Event, List<Ids>> with Model{
  Bloc(BuildContext context) : super([], context) {
    on<Increment>((event, emit) {
      count += event.num;
      emit([Ids.count]);
      if(count == 10) {
        Get.toNamed(Routes.countPage, arguments: "123456");
      }
    });
    on<Decrease>((event, emit) {
      count2--;
      count--;
      emit([Ids.count2, Ids.count]);
    });
  }
}
