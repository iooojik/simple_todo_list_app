import 'package:todo_list_app/entity/todo_item.dart';

class Model {
  final List<ToDoItem> items;

  Model({
    this.items = const <ToDoItem>[],
  });

  Model copyWith({
    List<ToDoItem>? items,
  }) {
    return Model(
      items: items ?? this.items,
    );
  }
}