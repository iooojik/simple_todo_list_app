import 'package:next_step_app/strings/vocab.dart';

class Strings {
  static String lang = "en";

  static String _strById(String strId) => Vocab.vocab[strId]![lang] ?? "";

  static String addTodoTooltip() => _strById("addTaskToolTip");

  static String addFolder() => _strById("addFolder");

  static String listFolders() => _strById("listFolders");
}
