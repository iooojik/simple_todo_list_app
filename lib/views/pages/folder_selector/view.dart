import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/entity/folder_item.dart';
import 'package:todo_list_app/strings/list.dart';
import 'package:todo_list_app/views/pages/folder_selector/view_model.dart';
import 'package:todo_list_app/views/pages/list/view.dart';
import 'package:todo_list_app/views/widgets/folder_item_widget.dart';

class FolderView extends StatefulWidget {
  const FolderView({Key? key}) : super(key: key);

  @override
  FolderViewState createState() => FolderViewState();

  static Widget create() => ChangeNotifierProvider(
        create: (_) => FolderViewModel(),
        child: const FolderView(),
      );
}

class FolderViewState extends State<FolderView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var viewModel = context.read<FolderViewModel>();
      viewModel.fetchFolders();
    });
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<FolderViewModel>();

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, int index) => FolderItemWidget(
                item: viewModel.state.items[index],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ToDoListView.create(
                              viewModel.state.items[index].id,
                            )),
                  );
                },
              ),
              itemCount: viewModel.state.items.length,
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              await viewModel
                  .addFolder(viewModel.state.items.length.toString());
            },
            child: Text(Strings.addFolder()),
          ),
        ],
      ),
    );
  }
}
