// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TodoCard extends StatefulWidget {
  final String todo;

  const TodoCard({super.key, required this.todo});

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Row(
              children: [
                Text(
                  widget.todo,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // Checkbox(
            //   value: widget.todo.done,
            //   onChanged: (newValue) {
            //     setState(() {});
            //     Database(firestore: widget.firestore).updateTodo(
            //       uid: widget.todo,
            //       todoId: widget.todo.todoId,
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
