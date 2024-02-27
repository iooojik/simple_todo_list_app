import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_list_app/entity/todo_item.dart';
import 'package:todo_list_app/views/pages/list/model.dart';

class ToDoListViewModel extends ChangeNotifier {
  ToDoListViewModel(this.folderId);

  var _state = Model();
  var folderId = -1;

  Model get state => _state;

  set state(Model val) {
    _state = _state.copyWith(items: val.items);
    notifyListeners();
  }

  String folderName() {
    if (folderId < 0) {
      return 'Folder title';
    }



    return '';
  }

  addItem(ToDoItem item) {
    var list = state.items.toList();

    list.add(item);
    state = state.copyWith(items: list);
  }

  dellItem(ToDoItem item) {
    var list = state.items.toList();

    list.removeWhere((element) => element.name == item.name);
    state = state.copyWith(items: list);
  }

  toogleItem(ToDoItem item) {
    var list = state.items.toList();
    var index = list.indexWhere((element) => element.name == item.name);

    list[index] = item.copyWith(done: !item.done);
    state = state.copyWith(items: list);
  }
}
