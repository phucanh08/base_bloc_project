import 'index.dart';

class View extends BlocView<Bloc> {
  const View({super.key});

  @override
  Bloc create(BuildContext context) => Bloc();

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  Widget _buildPage(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<Bloc, Event, State>(
            key: Ids.count.key,
            builder: (context, state, child) {
              return Center(
                child: Text('${state.count}'),
              );
            },
          ),
          textBuilder(),
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }

  AppBar get appbar => AppBar(
        title: const Text('Home2'),
      );

  Widget textBuilder() {
    return BlocBuilder<Bloc, Event, State>(
      key: Ids.count2.key,
      builder: (context, state, child) {
        return Center(
          child: Text('${state.count2}'),
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
              onPressed: () {
                bloc.add(const Increment(2));
              },
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
