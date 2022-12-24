import 'package:base_bloc_project/base_bloc_project.dart';
import 'package:flutter/material.dart';

class State extends BaseState {
  final int count;
  final int count2;

  const State({
    super.ids,
    super.status,
    this.count = 0,
    this.count2 = 0,
  });

  @override
  State copyWith({
    List<ValueKey> listIdUpdate = const [],
    CommonStatus? status,
    int? count,
    int? count2,
  }) {
    return State(
      ids: listIdUpdate,
      status: status ?? super.status,
      count: count ?? this.count,
      count2: count2 ?? this.count2,
    );
  }
}
