import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/strings/list.dart';
import 'package:todo_list_app/views/dialogs/todo_add_dialog.dart';
import 'package:todo_list_app/views/pages/folder_selector/view.dart';
import 'package:todo_list_app/views/pages/list/view_model.dart';
import 'package:todo_list_app/views/widgets/todo_item_widget.dart';

class ToDoListView extends StatelessWidget {
  const ToDoListView({Key? key, int id = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<ToDoListViewModel>();

    return Scaffold(
      body: ListView.builder(
        itemBuilder: (_, int index) => ToDoItemWidget(
          item: viewModel.state.items[index],
          onDelete: viewModel.dellItem,
          onToogle: viewModel.toogleItem,
        ),
        itemCount: viewModel.state.items.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (BuildContext context) {
                return FolderView.create();
          });
          // showDialog(
          //   context: context,
          //   builder: (_) => AddTaskDialog(onFinish: viewModel.addItem),
          // );
        },
        tooltip: Strings.addTodoTooltip(),
        child: const Icon(Icons.list_sharp),
      ),
    );
  }

  static Widget create(int pageId) => ChangeNotifierProvider(
        create: (_) => ToDoListViewModel(),
        child: ToDoListView(id: pageId),
      );
}
