import 'package:flutter/material.dart';
import 'package:todo_list_app/entity/folder_item.dart';

class FolderItemWidget extends StatelessWidget {
  final FolderItem item;
  final VoidCallback? onPressed;

  const FolderItemWidget({
    Key? key,
    required this.item,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        background: Container(color: Colors.red),
        key: Key(item.name),
        child: SizedBox(
          width: double.infinity,
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 20,
              ),
            ),
            onPressed: onPressed,
            child: Text(item.name),
          ),
        ));
  }
}
