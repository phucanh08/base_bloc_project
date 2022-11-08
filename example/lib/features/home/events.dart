import 'package:base_bloc_project/base_bloc_project.dart';

abstract class Event extends Equatable {
  const Event();

  @override
  List<Object> get props => [];
}

class Increment extends Event {
  final int num;

  const Increment([this.num = 1]);

  @override
  List<Object> get props => [num];
}

class Decrease extends Event {}
