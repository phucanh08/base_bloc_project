export 'bloc.dart';
export 'events.dart';
export 'ids.dart';
export 'model.dart';
export 'repository.dart';
export 'view.dart';

import 'package:base_bloc_project/base_bloc_project.dart';
import 'package:flutter/widgets.dart';
import 'view.dart';
import 'bloc.dart';


class Page extends StatelessWidget {
  const Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Bloc(),
      child: const View(),
    );
  }
}