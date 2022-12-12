import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as flutter_bloc;

class BlocBuilder<B extends flutter_bloc.StateStreamable<List<Id>>, Id>
    extends StatelessWidget {
  final Id? id;
  final flutter_bloc.BlocWidgetBuilder<List<Id>> builder;
  final Function(List<Id>, List<Id>)? buildWhen;

  const BlocBuilder(
      {this.id, super.key, required this.builder, this.buildWhen});

  @override
  Widget build(BuildContext context) => flutter_bloc.BlocBuilder<B, List<Id>>(
        builder: builder,
        buildWhen: (previous, current) {
              if(buildWhen != null) buildWhen!(previous, current);
              return id == null || current.isEmpty || current.contains(id);
            },
      );
}
