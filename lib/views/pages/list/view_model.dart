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
    FolderItem item = await _state.getFolder(folderId);
    List<ToDoItem> todos = await _state.getTodos(item.id);
    state = state.copyWith(folderItem: item, items: todos);
    return;
  }

  Future<void> saveFolder(FolderItem item) async {
    FolderItem folderItem = _state.folder;

    folderItem.name = item.name;

    await state.saveFolder(folderItem);

    // escaping notifyListeners in setter
    _state = _state.copyWith(folderItem: folderItem, items: state.items);
    return;
  }

  addItem(ToDoItem item) async {
    var list = state.items.toList();
    await state.addTodoItem(item);

    list.add(item);
    state = state.copyWith(folderItem: state.folder, items: list);
  }

  dellItem(ToDoItem item) async {
    var list = state.items.toList();

    list.removeWhere((element) => element.id == item.id);
    await state.delTodoItem(item);
    state = state.copyWith(folderItem: state.folder, items: list);
  }

  updateItem(ToDoItem item) async {
    var list = state.items.toList();

    await state.updTodoItem(item);

    _state = _state.copyWith(folderItem: state.folder, items: list);
  }

  toggleItem(ToDoItem item) async {
    var list = state.items.toList();

    await state.updTodoItem(item);

    state = state.copyWith(folderItem: state.folder, items: list);
  }
}
