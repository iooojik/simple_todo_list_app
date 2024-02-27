import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/entity/todo_item.dart';
import 'package:todo_list_app/strings/list.dart';
import 'package:todo_list_app/views/pages/folder_selector/view.dart';
import 'package:todo_list_app/views/pages/list/view_model.dart';
import 'package:todo_list_app/views/widgets/todo_item_widget.dart';

class ToDoListView extends StatefulWidget {
  const ToDoListView({Key? key}) : super(key: key);

  @override
  ToDoListViewState createState() => ToDoListViewState();

  static Widget create(int pageId) =>
      ChangeNotifierProvider(
        create: (_) => ToDoListViewModel(pageId),
        child: const ToDoListView(),
      );
}

class ToDoListViewState extends State<ToDoListView> {
  @override
  void initState() {
    super.initState();
  }

  Widget titleLoader(BuildContext context, AsyncSnapshot<String> snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.waiting:
        return const Text('');
      default:
        if (snapshot.hasError) {
          throw Exception(snapshot.error);
        } else {
          return TextFormField(
            initialValue: snapshot.data ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            keyboardType: TextInputType.multiline,
            maxLines: null,
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<ToDoListViewModel>();

    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FutureBuilder(
                future: viewModel.folderName(),
                builder: titleLoader,
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (_, int index) =>
                      ToDoItemWidget(
                        item: viewModel.state.items[index],
                        onDelete: viewModel.dellItem,
                        onToogle: viewModel.toogleItem,
                      ),
                  itemCount: viewModel.state.items.length,
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  await viewModel.addItem(
                    ToDoItem(
                      name: viewModel.state.items.length.toString(),
                      done: false,
                    ),
                  );
                },
                child: Text(Strings.addTodoTooltip()),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return FolderView.create();
            },
          );
        },
        tooltip: Strings.addTodoTooltip(),
        child: const Icon(Icons.list_sharp),
      ),
    );
  }
}
