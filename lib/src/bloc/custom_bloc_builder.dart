import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as flutter_bloc;

class BlocBuilder<B extends flutter_bloc.StateStreamable<List<Id>>, Id>
    extends StatelessWidget {
  final Id? id;
  final flutter_bloc.BlocWidgetBuilder<List<Id>> builder;
  final bool Function(List<Id>, List<Id>)? buildWhen;

  const BlocBuilder(
      {this.id, super.key, required this.builder, this.buildWhen});

  @override
  Widget build(BuildContext context) => flutter_bloc.BlocBuilder<B, List<Id>>(
        builder: builder,
        buildWhen: buildWhen ??
            (previous, current) =>
                current.isEmpty || (previous != current && (id == null || current.contains(id))),
      );
}
