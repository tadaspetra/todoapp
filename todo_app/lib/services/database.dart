import 'package:todo_app/models/todo.dart';

class Database {
  Future<TodoModel> loadDatabase() async {
    try {
      Future.delayed(const Duration(seconds: 3));
      return TodoModel(content: "From Database", done: true);
    } catch (e) {
      rethrow;
    }
  }
}
