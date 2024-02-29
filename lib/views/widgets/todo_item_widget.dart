import 'package:flutter/material.dart';
import 'package:todo_list_app/entity/todo_item.dart';

class ToDoItemWidget extends StatefulWidget {
  const ToDoItemWidget(
      {Key? key,
      required this.item,
      required this.onDelete,
      required this.onToggle})
      : super(key: key);

  final ToDoItem item;
  final Function(ToDoItem) onDelete;
  final Function(ToDoItem) onToggle;

  @override
  ToDoItemWidgetState createState() => ToDoItemWidgetState();
}

class ToDoItemWidgetState extends State<ToDoItemWidget> {
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    textController.addListener(_saveItem);
    super.initState();
  }

  void _saveItem() async {
    final text = textController.text;
    if (text != widget.item.text) {
      widget.item.text = text;
      widget.onToggle(widget.item);
    }
  }

  @override
  Widget build(BuildContext context) {
    textController.text = widget.item.text;

    return Dismissible(
      background: Container(color: Colors.red),
      key: Key(widget.item.text),
      onDismissed: (_) {
        widget.onDelete(widget.item);
      },
      child: Column(
        children: [
          TextFormField(
            controller: textController,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Checkbox(
                  value: widget.item.done,
                  onChanged: (value) {
                    widget.onToggle(widget.item);
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
