import 'package:flutter/material.dart';

import '../constants.dart';

class dialogBox extends StatelessWidget {
  final controller;
  VoidCallback onEdit;
  VoidCallback onCancel;
  dialogBox(
      {Key? key,
      required this.controller,
      required this.onCancel,
      required this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Edit TODO',
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: ColorConstants.colorList[5]),
                border: OutlineInputBorder(),
                hintText: 'Enter new Todo',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onCancel,
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                TextButton(
                    onPressed: onEdit,
                    child: Text(
                      'Edit',
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
