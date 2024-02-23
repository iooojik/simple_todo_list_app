import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/views/pages/main/view_model.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<MainViewModel>();

    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<Widget>(
          future: viewModel.getPage(),
          builder: windowLoader,
        ));
  }

  Widget windowLoader(BuildContext context, AsyncSnapshot<Widget> snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.waiting:
        return const Text('');
      default:
        if (snapshot.hasError) {
          throw Exception(snapshot.error);
        } else {
          return snapshot.data ?? const Text('');
        }
    }
  }

  static Widget create() => ChangeNotifierProvider(
        create: (_) => MainViewModel(),
        child: const MainView(),
      );
}
