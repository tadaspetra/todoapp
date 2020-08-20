import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/controllers/list_controller.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/database.dart';

class MockDatabase extends Mock implements Database {}

void main() {
  final MockDatabase _mockDatabase = MockDatabase();
  ListController _listController;
  setUp(() {
    _listController = ListController(database: _mockDatabase);
  });

  tearDown(() {
    _listController.clear(); //optional for this scenario
  });
  test("Initializes with empty", () {
    expect(_listController.todoList.length, 0);
  });

  test("Todo Added", () {
    _listController.addTodo(
        todo: TodoModel(content: "Get Groceries", done: false));
    expect(_listController.todoList.length, 1);
    expect(_listController.todoList[0].content, "Get Groceries");
  });

  test("Checkbox Selected", () {
    _listController.addTodo(
        todo: TodoModel(content: "Get Groceries", done: false));
    expect(_listController.todoList[0].done, false);
    _listController.checkboxSelected(newValue: true, index: 0);
    expect(_listController.todoList[0].done, true);
  });

  test("Mock Database call", () async {
    when(_mockDatabase.loadDatabase()).thenAnswer(
      (realInvocation) => Future.value(
        TodoModel(content: "From Mock", done: true),
      ),
    );
    await _listController.loadFromDatabase();
    expect(_listController.todoList[0].content, "From Mock");
  });
}
