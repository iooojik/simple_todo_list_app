import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_list_app/entity/folder_item.dart';
import 'package:todo_list_app/entity/todo_item.dart';
import 'package:todo_list_app/views/pages/list/model.dart';

class ToDoListViewModel extends ChangeNotifier {
  ToDoListViewModel();

  var _state = Model(FolderItem(-1, ""));

  Model get state => _state;

  set state(Model val) {
    _state = _state.copyWith(folderItem: val.folder, items: val.items);
    notifyListeners();
  }

  Future<void> initFolder(int folderId) async {
    // if (folder.id < 0) {
    //   folder.name = 'Folder title';
    //   notifyListeners();
    //   return;
    // }
    //
    FolderItem item = await _state.getFolder(folderId);
    state = state.copyWith(folderItem: item, items: state.items);

    return;
  }

  addItem(ToDoItem item) {
    var list = state.items.toList();

    list.add(item);
    state = state.copyWith(folderItem: state.folder, items: list);
  }

  dellItem(ToDoItem item) {
    var list = state.items.toList();

    list.removeWhere((element) => element.name == item.name);
    state = state.copyWith(folderItem: state.folder, items: list);
  }

  toogleItem(ToDoItem item) {
    var list = state.items.toList();
    var index = list.indexWhere((element) => element.name == item.name);

    list[index] = item.copyWith(done: !item.done);
    state = state.copyWith(folderItem: state.folder, items: list);
  }
}
