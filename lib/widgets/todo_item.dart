import 'package:flutter/material.dart';
import 'package:todo_app_flutter/widgets/dialog_box.dart';
import '../constants.dart';
import '../models/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo1;
  final todoCompleted;
  final deleteItem;
  final editItem;
  final controller = TextEditingController();
  var data;

  final _todoController = TextEditingController();
  ToDoItem(
      {Key? key,
      required this.todo1,
      required this.todoCompleted,
      required this.deleteItem,
      required this.editItem,
      required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: () {
          editTask(context);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: ColorConstants.colorList[4],
        leading: IconButton(
          icon: Icon(
              todo1.isdone ? Icons.check_box : Icons.check_box_outline_blank),
          onPressed: () {
            todoCompleted(todo1);
          },
          color: ColorConstants.colorList[8],
        ),
        title: Text(
          '${todo1.id.toString().substring(11, 16)} :-  ${todo1.todotext!}',
          style: TextStyle(
              fontSize: 16,
              color: ColorConstants.colorList[5],
              decoration: todo1.isdone ? TextDecoration.lineThrough : null),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: tred, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: IconButton(
              padding: EdgeInsets.all(5),
              color: Colors.white,
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteItem(todo1.id, todo1);
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> editTask(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return dialogBox(
            controller: controller,
            onCancel: () {
              Navigator.of(context).pop();
            },
            onEdit: () {
              String newText = controller.text;
              editItem(newText, todo1);
              Navigator.of(context).pop();
            },
          );
        });
  }
}
