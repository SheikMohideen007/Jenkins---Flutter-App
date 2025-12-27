import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'todo.dart';

class TodoService {
  static TodoService? _instance;
  static const String _todosKey = 'todos';

  TodoService._();

  static TodoService get instance {
    _instance ??= TodoService._();
    return _instance!;
  }

  // For testing purposes
  static void resetInstance() {
    _instance = null;
  }

  Future<List<Todo>> getTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = prefs.getStringList(_todosKey) ?? [];
    return todosJson.map((json) => Todo.fromJson(jsonDecode(json))).toList();
  }

  Future<void> addTodo(Todo todo) async {
    final todos = await getTodos();
    todos.add(todo);
    await _saveTodos(todos);
  }

  Future<void> updateTodo(Todo updatedTodo) async {
    final todos = await getTodos();
    final index = todos.indexWhere((todo) => todo.id == updatedTodo.id);
    if (index != -1) {
      todos[index] = updatedTodo;
      await _saveTodos(todos);
    }
  }

  Future<void> deleteTodo(String id) async {
    final todos = await getTodos();
    todos.removeWhere((todo) => todo.id == id);
    await _saveTodos(todos);
  }

  Future<void> _saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = todos.map((todo) => jsonEncode(todo.toJson())).toList();
    await prefs.setStringList(_todosKey, todosJson);
  }
}
