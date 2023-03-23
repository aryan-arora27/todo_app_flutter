import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class ToDo extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? todotext;

  @HiveField(2)
  bool isdone;
  ToDo({required this.id, required this.todotext, this.isdone = false});
  static List<ToDo> todolist() {
    return [
      // ToDo(id: '01', todotext: 'abcd', isdone: true),
      // ToDo(id: '02', todotext: 'abcde', isdone: true),
      // ToDo(id: '03', todotext: 'abcdef'),
      // ToDo(id: '04', todotext: 'abcdefg'),
      // ToDo(id: '05', todotext: 'abcdefgh'),
    ];
  }
}
