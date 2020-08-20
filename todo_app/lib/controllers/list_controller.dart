import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/database.dart';

class ListController {
  final Database database;
  List<TodoModel> todoList = <TodoModel>[];

  ListController({this.database});

  void addTodo({TodoModel todo}) {
    todoList.add(todo);
  }

  void checkboxSelected({bool newValue, int index}) {
    todoList[index].done = newValue;
  }

  void clear() {
    todoList.clear();
  }

  Future<void> loadFromDatabase() async {
    todoList.add(await database.loadDatabase());
  }
}
