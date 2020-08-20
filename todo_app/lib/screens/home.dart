import 'package:flutter/material.dart';
import 'package:todo_app/controllers/list_controller.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/database.dart';
import 'package:todo_app/widgets/todo_card.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _todoController = TextEditingController();
  ListController listController = ListController(database: Database());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List App"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Add Todo Here:",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Card(
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _todoController,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      if (_todoController.text != "") {
                        listController.addTodo(
                          todo: TodoModel(
                            content: _todoController.text,
                            done: false,
                          ),
                        );
                        //Database()
                        //.addTodo(_todoController.text, controller.user.uid);
                        _todoController.clear();
                        setState(() {});
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          RaisedButton(
            onPressed: () {
              listController.loadFromDatabase();
              setState(() {});
            },
            child: const Text("Load Todo from Database"),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Your Todos",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listController.todoList.length,
              itemBuilder: (_, index) {
                return TodoCard(index: index, listController: listController);
              },
            ),
          )
        ],
      ),
    );
  }
}
