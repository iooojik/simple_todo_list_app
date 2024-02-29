import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/entity/todo_item.dart';
import 'package:todo_list_app/strings/list.dart';
import 'package:todo_list_app/views/pages/folder_selector/view.dart';
import 'package:todo_list_app/views/pages/list/view_model.dart';
import 'package:todo_list_app/views/widgets/todo_item_widget.dart';

class ToDoListView extends StatefulWidget {
  const ToDoListView({Key? key, required this.folderId}) : super(key: key);

  final int folderId;

  @override
  ToDoListViewState createState() => ToDoListViewState();

  static Widget create(int pageId) => ChangeNotifierProvider(
        create: (_) => ToDoListViewModel(),
        child: ToDoListView(
          folderId: pageId,
        ),
      );
}

class ToDoListViewState extends State<ToDoListView> {
  final TextEditingController titleTextController = TextEditingController();
  late ToDoListViewModel viewModel;

  @override
  void initState() {
    super.initState();
    titleTextController.addListener(_saveTitle);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.initFolder(widget.folderId);
    });
  }

  void _saveTitle() {
    final text = titleTextController.text;
    viewModel.state.folder.name = text;
    viewModel.saveFolder(viewModel.state.folder);
  }

  @override
  Widget build(BuildContext context) {
    viewModel = context.watch<ToDoListViewModel>();

    titleTextController.text = viewModel.state.folder.name;

    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleTextController,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.text,
                maxLines: 1,
                maxLength: 48,
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (_, int index) => ToDoItemWidget(
                    item: viewModel.state.items[index],
                    onDelete: viewModel.dellItem,
                    onToggle: viewModel.toggleItem,
                  ),
                  itemCount: viewModel.state.items.length,
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  await viewModel.addItem(
                    ToDoItem(
                      text: "ToDo",
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
