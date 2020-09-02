import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/database.dart';

class TodoCard extends StatefulWidget {
  final TodoModel todo;
  final FirebaseFirestore firestore;
  final String uid;

  const TodoCard({Key key, this.todo, this.firestore, this.uid})
      : super(key: key);

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
            Expanded(
              child: Text(
                widget.todo.content,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Checkbox(
              value: widget.todo.done,
              onChanged: (newValue) {
                setState(() {});
                Database(firestore: widget.firestore).updateTodo(
                  uid: widget.uid,
                  todoId: widget.todo.todoId,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
