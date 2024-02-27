import 'package:flutter/material.dart';
import 'package:todo_list_app/entity/folder_item.dart';
import 'package:todo_list_app/views/pages/folder_selector/model.dart';

class FolderViewModel extends ChangeNotifier {
  var _state = Model();

  Model get state => _state;

  set state(Model val) {
    _state = _state.copyWith(items: val.items);
    notifyListeners();
  }

  Future<void> fetchFolders() async {
    List<FolderItem> folders = await _state.getFolders();

    state = state.copyWith(items: folders);
  }

  addFolder(String name) async {
    // var list = state.items.toList();
    // if (!list.any((element) => element.name == item.name)) {
    //   _state.addFolder(item);
    //
    //   list.add(item);
    //
    //   state = state.copyWith(items: list);
    // }
  }
}
