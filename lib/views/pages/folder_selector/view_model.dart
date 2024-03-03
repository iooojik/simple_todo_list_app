import 'package:flutter/material.dart';
import 'package:next_step_app/entity/folder_item.dart';
import 'package:next_step_app/views/pages/folder_selector/model.dart';

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
    FolderItem item = FolderItem(-1, name);

    var list = state.items.toList();

    await state.addFolder(item);

    list.add(item);

    state = state.copyWith(items: list);
  }

  deleteFolder(int id) async {
    var list = state.items.toList();

    list.removeWhere((element) => element.id == id);

    await state.deleteFolder(id);

    state = state.copyWith(items: list);
  }
}
