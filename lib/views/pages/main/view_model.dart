import 'package:flutter/material.dart';
import 'package:todo_list_app/views/pages/list/view.dart';
import 'package:todo_list_app/views/pages/main/model.dart';

class MainViewModel extends ChangeNotifier {
  var _state = Model();

  Model get state => _state;

  set state(Model val) {
    _state = _state.copyWith(name: val.name);
    notifyListeners();
  }

  Future<Widget> getPage() async {
    return ToDoListView.create(-1);
  }

// addItem(ToDoItem item) {
//   var list = state.items.toList();
//   if (list.any((element) => element.name == item.name)) {
//     throw Error();
//   } else {
//     list.add(item);
//     state = state.copyWith(items: list);
//   }
// }
}
