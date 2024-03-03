import 'package:flutter/material.dart';
import 'package:next_step_app/entity/folder_item.dart';

class FolderItemWidget extends StatefulWidget {
  const FolderItemWidget({
    Key? key,
    required this.item,
    required this.onPressed,
    required this.onDelete,
  }) : super(key: key);

  final FolderItem item;
  final VoidCallback? onPressed;
  final Function(int) onDelete;

  @override
  FolderItemWidgetState createState() => FolderItemWidgetState();
}

class FolderItemWidgetState extends State<FolderItemWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        background: Container(color: Colors.red),
        key: Key(widget.item.name),
        onDismissed: (_) {
          widget.onDelete(widget.item.id);
        },
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 20,
                ),
              ),
              onPressed: widget.onPressed,
              child: Text(widget.item.name),
            ),
          ),
        ));
  }
}
