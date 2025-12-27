// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:jenkins_sample_flutter_app/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Todo app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app starts with no todos.
    expect(find.text('No todos yet. Add one!'), findsOneWidget);

    // Tap the add button to open the dialog.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify the dialog is shown.
    expect(find.text('Add Todo'), findsOneWidget);

    // Enter a title.
    await tester.enterText(find.byType(TextField).first, 'Test Todo');

    // Tap the add button in the dialog.
    await tester.tap(find.text('Add'));
    await tester.pump();

    // Verify the todo is added.
    expect(find.text('Test Todo'), findsOneWidget);
    expect(find.text('No todos yet. Add one!'), findsNothing);
  });

  testWidgets('Toggle todo completion', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Add a todo.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    await tester.enterText(find.byType(TextField).first, 'Test Todo');
    await tester.tap(find.text('Add'));
    await tester.pump();

    // Verify it's not completed.
    expect(find.byType(Checkbox).first, findsOneWidget);
    expect(tester.widget<Checkbox>(find.byType(Checkbox).first).value, false);

    // Tap the checkbox to toggle.
    await tester.tap(find.byType(Checkbox).first);
    await tester.pump();

    // Verify it's completed.
    expect(tester.widget<Checkbox>(find.byType(Checkbox).first).value, true);
  });

  testWidgets('Delete todo', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Add a todo.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    await tester.enterText(find.byType(TextField).first, 'Test Todo');
    await tester.tap(find.text('Add'));
    await tester.pump();

    // Verify the todo is there.
    expect(find.text('Test Todo'), findsOneWidget);

    // Tap the delete button.
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    // Verify the todo is deleted.
    expect(find.text('Test Todo'), findsNothing);
    expect(find.text('No todos yet. Add one!'), findsOneWidget);
  });
}
