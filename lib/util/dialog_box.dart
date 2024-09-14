import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({super.key});



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 200,
        width: 1000,
        child: const Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Add task here",
              ),
            )
          ],
      )
      ),
    );
  }
}