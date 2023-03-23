import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app_flutter/boxes/boxes.dart';
import '../constants.dart';
import '../widgets/todo_item.dart';
import '../models/todo.dart';
import '../constants.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ToDo> todoslist = ToDo.todolist();
  List<ToDo> _foundTodo = [];
  final _todoController = TextEditingController();
  bool theme = true;

  @override
  void initState() {
    _foundTodo = todoslist;

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstants.colorList[2],
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 0,
                    bottom: 20,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      'All ToDo\'s',
                      style: TextStyle(
                        fontSize: 30,
                        color: ColorConstants.colorList[3],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                ValueListenableBuilder<Box<ToDo>>(
                    valueListenable: Boxes.getData().listenable(),
                    builder: (context, box, _) {
                      var data = box.values.toList().cast<ToDo>();
                      return Expanded(
                        child: ListView.builder(
                            itemCount: box.length,
                            itemBuilder: (context, index) {
                              return ToDoItem(
                                todo1: data[index],
                                todoCompleted: _changeHandler,
                                deleteItem: _deleteItem,
                                editItem: _editTask,
                                data: data,
                              );
                            }),
                      );
                    })
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin:
                        const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10.0)),
                    child: TextFormField(
                      controller: _todoController,
                      decoration: const InputDecoration(
                        hintText: 'Add a new ToDo item',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () async {
                      addItem(_todoController.text);
                      _todoController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tBlue,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                    ),
                    child: const Text(
                      '+',
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void addItem(String ToDoo) {
    setState(() {
      if (ToDoo.isEmpty || ToDoo == '') {
        getSnackbar('Please write a ToDo', context);
      } else {
        todoslist
            .add(ToDo(id: DateTime.now().toIso8601String(), todotext: ToDoo));
        final data =
            ToDo(id: DateTime.now().toIso8601String(), todotext: ToDoo);
        final box = Boxes.getData();
        box.add(data);
        data.save();
        print(box);
        print(box.length);
      }
    });
  }

  void _deleteItem(String id, ToDo toDo) async {
    await toDo.delete();
    setState(() {
      todoslist.removeWhere((item) => item.id == id);
    });
  }

  void _changeHandler(ToDo todo12) {
    setState(() {
      todo12.isdone = !todo12.isdone;
      todo12.save();
    });
  }

  void _editTask(String newText, ToDo todo12) {
    setState(() {
      todo12.todotext = newText;
      todo12.save();
    });
  }

  void _resetTasks() {
    setState(() {
      todoslist = [];
      _foundTodo = todoslist;
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: ColorConstants.colorList[2],
      title: Row(
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                _resetTasks();
                final box = Boxes.getData();
                box.clear();
              });
            },
            icon: Icon(Icons.restart_alt),
            color: ColorConstants.colorList[3],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 90),
            child: Text(
              'ToDo',
              style: TextStyle(color: ColorConstants.colorList[3]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 95),
            child: IconButton(
                onPressed: () {
                  theme = !theme;
                  ColorConstants().changeTheme();
                  setState(() {});
                },
                icon: Icon(
                  !theme ? Icons.sunny : Icons.nightlight,
                  color: ColorConstants.colorList[3],
                )),
          ),
        ],
      ),
    );
  }
}
