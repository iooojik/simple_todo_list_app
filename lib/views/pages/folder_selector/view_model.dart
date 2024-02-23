import 'package:flutter/material.dart';
import 'package:todo_list_app/entity/folder_item.dart';
import 'package:todo_list_app/entity/todo_item.dart';
import 'package:todo_list_app/views/pages/folder_selector/model.dart';

class FolderViewModel extends ChangeNotifier {
  var _state = Model();

  Model get state => _state;

  set state(Model val) {
    _state = _state.copyWith(items: val.items);
    notifyListeners();
  }


}
