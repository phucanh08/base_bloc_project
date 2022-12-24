import 'package:base_bloc_project/base_bloc_project.dart';
import 'package:flutter/cupertino.dart';

abstract class BlocView<B extends BlocBase> extends Widget {
  const BlocView({super.key});

  B create(BuildContext context);

  Widget build(BuildContext context);

  @override
  StatelessElement createElement() => StatelessElement(
        BlocProvider<B>(
          create: create,
          child: Builder(
            builder: (context) {
              return build(context);
            },
          ),
        ),
      );
}
