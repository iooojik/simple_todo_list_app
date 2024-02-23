import 'package:todo_list_app/strings/vocab.dart';

class Strings {
  static String lang = "en";

  static String _strById(String strId) => Vocab.vocab[strId]![lang] ?? "";

  static String addTodoTooltip() => _strById("addTaskToolTip");
}
