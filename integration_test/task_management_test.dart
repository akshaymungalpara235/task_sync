import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:task_sync/main.dart' as app;
import 'package:task_sync/data/database/database_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

Future<void> userTap(WidgetTester tester, Finder finder) async {
  await tester.tap(finder);
  await tester.pumpAndSettle();

  // Delay to mimic user behavior
  await Future.delayed(const Duration(milliseconds: 800));
}

Future<void> userEnterText(
    WidgetTester tester, Finder finder, String text) async {
  await tester.enterText(finder, text);
  await tester.pumpAndSettle();
  // Delay to mimic user behavior
  await Future.delayed(const Duration(milliseconds: 500));
}

Future<void> userSwitchTab(WidgetTester tester, String tabName) async {
  await userTap(tester, find.text(tabName));

  // Delay to mimic user behavior
  await Future.delayed(const Duration(milliseconds: 300));
}

Future<void> userCreateTask(
    WidgetTester tester, String title, String description) async {
  await userTap(tester, find.byType(FloatingActionButton));

  // Delay to mimic user behavior
  await Future.delayed(const Duration(milliseconds: 500));

  await userEnterText(tester, find.byType(TextFormField).first, title);
  await userEnterText(tester, find.byType(TextFormField).last, description);

  await userTap(tester, find.text('Save Task'));

  // Delay to mimic user behavior
  await Future.delayed(const Duration(milliseconds: 1000));
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    // Access SQLite DB with test_task db name
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, 'test_tasks.db');

    // Delete existing test database if it exists
    // If database will exist with the same name, it may affect on further test.
    if (await File(dbPath).exists()) {
      await File(dbPath).delete();
    }

    // Set test database name and initialize
    DatabaseHelper.setDatabaseName('test_tasks.db');
    await DatabaseHelper.instance.database;
  });

  tearDownAll(() async {
    // Clean up SQLite database
    final db = await DatabaseHelper.instance.database;
    await db.close();

    // Delete test database
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, 'test_tasks.db');
    if (await File(dbPath).exists()) {
      await File(dbPath).delete();
    }
  });

  group('Task Management Flow', () {
    testWidgets('Tab navigation verification', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Initial app load delay
      await Future.delayed(const Duration(milliseconds: 1000));

      // Switch to Completed tab
      await userSwitchTab(tester, 'Completed');

      // Verify only completed task is visible
      expect(find.text('Completed Task'), findsNothing);
      expect(find.text('Pending Task'), findsNothing);

      // Switch to Pending tab
      await userSwitchTab(tester, 'Pending');

      // Verify only pending task is visible
      expect(find.text('Completed Task'), findsNothing);
      expect(find.text('Pending Task'), findsNothing);
    });
    testWidgets('Create, complete, and delete a task',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Initial app load delay
      await Future.delayed(const Duration(milliseconds: 1000));

      // Verify initial state - All Tasks tab
      expect(find.text('All Tasks'), findsOneWidget);
      expect(find.text('No tasks yet. Add one by clicking the + button!'),
          findsOneWidget);

      // Create a new task
      await userCreateTask(tester, 'Test Task', 'Test Description');

      // Verify task is created and visible
      expect(find.text('Test Task'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);

      // Toggle task completion
      await userTap(tester, find.byType(Checkbox));

      // Delay after status change
      await Future.delayed(const Duration(milliseconds: 500));

      // Verify task is marked as completed
      expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, true);

      // Switch to Completed tab
      await userSwitchTab(tester, 'Completed');

      // Verify task appears in Completed tab
      expect(find.text('Test Task'), findsOneWidget);

      // Switch to Pending tab
      await userSwitchTab(tester, 'Pending');

      // Verify task doesn't appear in Pending tab
      expect(find.text('Test Task'), findsNothing);

      // Switch back to All Tasks tab
      await userSwitchTab(tester, 'All Tasks');

      // Delete the task
      await userTap(tester, find.byIcon(Icons.delete));

      // Delay after deletion to mimic user behavior
      await Future.delayed(const Duration(milliseconds: 800));

      // Verify task is deleted
      expect(find.text('Test Task'), findsNothing);
      expect(find.text('No tasks yet. Add one by clicking the + button!'),
          findsOneWidget);
    });

    testWidgets('Form validation and error handling',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Initial app load delay
      await Future.delayed(const Duration(milliseconds: 1000));

      // Try to create task without title
      await userTap(tester, find.byType(FloatingActionButton));

      await userTap(tester, find.text('Save Task'));

      // Verify error message
      expect(find.text('Please enter a title'), findsOneWidget);

      // Delay to read error to mimic user behavior
      await Future.delayed(const Duration(milliseconds: 500));

      // Cancel task creation
      await userTap(tester, find.byIcon(Icons.close));

      // Verify form is closed
      expect(find.text('Save Task'), findsNothing);
    });

    testWidgets('Tab navigation verification with task',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Initial app load delay
      await Future.delayed(const Duration(milliseconds: 1000));

      // Create a completed task
      await userCreateTask(
          tester, 'Completed Task', 'This is a completed task');

      // Mark as completed
      await userTap(tester, find.byType(Checkbox));

      // Delay after status change
      await Future.delayed(const Duration(milliseconds: 500));

      // Create a pending task
      await userCreateTask(tester, 'Pending Task', 'This is a pending task');

      // Verify tasks in All Tasks tab
      expect(find.text('Completed Task'), findsOneWidget);
      expect(find.text('Pending Task'), findsOneWidget);

      // Switch to Completed tab
      await userSwitchTab(tester, 'Completed');

      // Verify only completed task is visible
      expect(find.text('Completed Task'), findsOneWidget);
      expect(find.text('Pending Task'), findsNothing);

      // Switch to Pending tab
      await userSwitchTab(tester, 'Pending');

      // Verify only pending task is visible
      expect(find.text('Completed Task'), findsNothing);
      expect(find.text('Pending Task'), findsOneWidget);
    });
  });
}
