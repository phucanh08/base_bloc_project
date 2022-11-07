import 'package:base_bloc_project/base_bloc_project.dart';
import 'package:flutter/material.dart';
import 'index.dart';

class View extends StatelessWidget {
  const View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<Bloc>();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<Bloc, Ids>(
            id: Ids.count,
            builder: (context, ids) {
              return Center(
                child: Text('${bloc.model.count}'),
              );
            },
          ),
          BlocBuilder<Bloc, Ids>(
            id: Ids.count2,
            builder: (context, ids) {
              return Center(
                child: Text('${bloc.model.count2}'),
              );
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => bloc.add(const Increment(2)),
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () => bloc.add(Decrease()),
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
