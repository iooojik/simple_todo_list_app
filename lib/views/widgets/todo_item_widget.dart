import 'package:flutter/material.dart';
import 'package:todo_list_app/entity/todo_item.dart';

class ToDoItemWidget extends StatelessWidget {
  final ToDoItem item;
  final Function(ToDoItem) onDelete;
  final Function(ToDoItem) onToogle;

  const ToDoItemWidget({
    Key? key,
    required this.item,
    required this.onDelete,
    required this.onToogle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(color: Colors.red),
      key: Key(item.name),
      onDismissed: (_) {
        onDelete(item);
      },
      child: Column(
        children: [
          TextFormField(
            initialValue: 'Input text',
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Checkbox(
                  value: item.done,
                  onChanged: (value) {
                    onToogle(item);
                  }),
            ),
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
          const SizedBox(
            height: 4.0,
          )
        ],
      ),
    );
  }
}
