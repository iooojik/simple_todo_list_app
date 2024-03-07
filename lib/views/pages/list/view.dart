import 'package:flutter/material.dart';
import 'package:next_step_app/entity/todo_item.dart';
import 'package:next_step_app/strings/list.dart';
import 'package:next_step_app/views/pages/folder_selector/view.dart';
import 'package:next_step_app/views/pages/list/view_model.dart';
import 'package:next_step_app/views/widgets/todo_item_widget.dart';
import 'package:provider/provider.dart';

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

  Widget _buildTodoItem(ToDoItem item) {
    return ListTile(
      key: ValueKey(item),
      title: ToDoItemWidget(
        item: item,
        onDelete: viewModel.dellItem,
        onToggle: viewModel.toggleItem,
        onUpdate: viewModel.updateItem,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    viewModel = context.watch<ToDoListViewModel>();
    final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

    titleTextController.text = viewModel.state.folder.name;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 48, 8, 8),
        child: Container(
            padding: const EdgeInsets.all(8.0),
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
                const SizedBox(height: 4.0),
                Expanded(
                  child: ReorderableListView(
                    key: listKey,
                    onReorder: viewModel.onReorder,
                    children: viewModel.state.items
                        .map((ToDoItem item) => _buildTodoItem(item))
                        .toList(),
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
      ),
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
