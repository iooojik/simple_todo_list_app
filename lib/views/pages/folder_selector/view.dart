import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/views/pages/folder_selector/view_model.dart';
import 'package:todo_list_app/views/widgets/folder_item_widget.dart';

class FolderView extends StatelessWidget {
  const FolderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<FolderViewModel>();

    return ListView.builder(
      itemBuilder: (_, int index) => FolderItemWidget(
        item: viewModel.state.items[index],
        // onDelete: viewModel.dellItem,
        // onToogle: viewModel.toogleItem,
      ),
      itemCount: viewModel.state.items.length,
    );
  }

  static Widget create() => ChangeNotifierProvider(
        create: (_) => FolderViewModel(),
        child: const FolderView(),
      );
}
