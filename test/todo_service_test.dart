import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jenkins_sample_flutter_app/todo.dart';
import 'package:jenkins_sample_flutter_app/todo_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TodoService', () {
    late TodoService todoService;

    setUp(() {
      TodoService.resetInstance();
      todoService = TodoService.instance;
      SharedPreferences.setMockInitialValues({});
    });

    test('should add and get todos', () async {
      final todo = Todo(
        id: '1',
        title: 'Test Todo',
        description: 'Description',
      );

      await todoService.addTodo(todo);
      final todos = await todoService.getTodos();

      expect(todos.length, 1);
      expect(todos[0].id, '1');
      expect(todos[0].title, 'Test Todo');
      expect(todos[0].description, 'Description');
      expect(todos[0].isCompleted, false);
    });

    test('should update todo', () async {
      final todo = Todo(id: '1', title: 'Test Todo');
      await todoService.addTodo(todo);

      final updatedTodo = Todo(
        id: '1',
        title: 'Updated Todo',
        isCompleted: true,
      );
      await todoService.updateTodo(updatedTodo);

      final todos = await todoService.getTodos();
      expect(todos[0].title, 'Updated Todo');
      expect(todos[0].isCompleted, true);
    });

    test('should delete todo', () async {
      final todo = Todo(id: '1', title: 'Test Todo');
      await todoService.addTodo(todo);

      await todoService.deleteTodo('1');
      final todos = await todoService.getTodos();

      expect(todos.length, 0);
    });
  });
}
