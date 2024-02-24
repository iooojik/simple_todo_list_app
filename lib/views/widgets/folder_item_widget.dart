import 'package:flutter/material.dart';
import 'package:todo_list_app/entity/folder_item.dart';

class FolderItemWidget extends StatelessWidget {
  final FolderItem item;

  // final Function(ToDoItem) onDelete;
  // final Function(ToDoItem) onToogle;

  const FolderItemWidget({
    Key? key,
    required this.item,
    // required this.onDelete,
    // required this.onToogle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(color: Colors.red),
      key: Key(item.name),
      child: Text(item.name),
      // onDismissed: (_) {
      //   onDelete(item);
      // },
      // child: CheckboxListTile(
      //   value: item.done,
      //   onChanged: (_) {
      //     onToogle(item);
      //   },
      //   title: Text(item.name),
    );
  }
}
