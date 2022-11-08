import 'package:base_bloc_project/base_bloc_project.dart';
import 'package:flutter/material.dart';
import 'index.dart';

class View extends StatelessWidget {
  const View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Bloc(context),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<Bloc>(context);
    return Scaffold(
      appBar: appbar,
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
          textBuilder(),
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }

  AppBar get appbar => AppBar(title: const Text('Home'),);

  Widget textBuilder() {
    return BlocBuilder<Bloc, Ids>(
      id: Ids.count2,
      builder: (context, ids) {
        final bloc = BlocProvider.of<Bloc>(context);
        return Center(
          child: Text('${bloc.model.count2}'),
        );
      },
    );
  }

  Widget get floatingActionButton {
    return Builder(
      builder: (context) {
        final bloc = BlocProvider.of<Bloc>(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "btn1",
              onPressed: () => bloc.add(const Increment(2)),
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              heroTag: "btn2",
              onPressed: () => bloc.add(Decrease()),
              child: const Icon(Icons.remove),
            ),
          ],
        );
      },
    );
  }
}
