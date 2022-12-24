import 'package:base_bloc_project/base_bloc_project.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as flutter_bloc;

typedef BlocWidgetBuilder<S> = Widget Function(
    BuildContext context, S state, Widget? child);

class BlocBuilder<B extends BlocBase<E, S>, E, S extends BaseState>
    extends StatefulWidget {
  final B? bloc;
  final BlocBuilderCondition<S>? buildWhen;
  final BlocWidgetBuilder<S> builder;
  final Widget? child;

  const BlocBuilder({
    super.key,
    this.bloc,
    this.buildWhen,
    required this.builder,
    this.child,
  });

  Widget build(BuildContext context, S state) => builder(context, state, child);

  @override
  State<BlocBuilder<B, E, S>> createState() => _BlocBuilderState<B, E, S>();
}

class _BlocBuilderState<B extends BlocBase<E, S>, E, S extends BaseState>
    extends State<BlocBuilder<B, E, S>> {
  late B _bloc;
  late S _state;

  @override
  void initState() {
    super.initState();
    _bloc = widget.bloc ?? context.read<B>();
    _state = _bloc.state;
  }

  @override
  void didUpdateWidget(BlocBuilder<B, E, S> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldBloc = oldWidget.bloc ?? context.read<B>();
    final currentBloc = widget.bloc ?? oldBloc;
    if (oldBloc != currentBloc) {
      _bloc = currentBloc;
      _state = _bloc.state;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final bloc = widget.bloc ?? context.read<B>();
    if (_bloc != bloc) {
      _bloc = bloc;
      _state = _bloc.state;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.bloc == null) {
      context.select<B, bool>((bloc) => identical(_bloc, bloc));
    }
    return BlocListener<B, S>(
      bloc: _bloc,
      listenWhen: (previous, current) {
        final bool buildWhen = widget.buildWhen != null
            ? widget.buildWhen!(previous, current)
            : false;
        return widget.key == null ||
            current.ids.isEmpty ||
            current.ids.contains(widget.key) ||
            buildWhen;
      },
      listener: (context, state) => setState(() => _state = state),
      child: widget.build(context, _state),
    );
  }
}
