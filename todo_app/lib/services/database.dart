import 'package:todo_app/models/todo.dart';

class Database {
  Future<TodoModel> loadDatabase() async {
    try {
      Future.delayed(Duration(seconds: 3));
      return TodoModel("From Database", true);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
