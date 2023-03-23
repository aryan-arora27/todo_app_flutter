import 'package:hive/hive.dart';

import '../models/todo.dart';

class Boxes {
  static Box<ToDo> getData() => Hive.box('todos');
}
