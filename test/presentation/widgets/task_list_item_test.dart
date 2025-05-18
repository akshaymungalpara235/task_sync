import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_sync/domain/entity/task.dart';
import 'package:task_sync/presentation/task/screen/widget/task_list_item.dart';

void main() {
  late Task mockTask;
  late VoidCallback mockOnToggleComplete;
  late VoidCallback mockOnDelete;
  late VoidCallback mockOnEdit;

  setUp(() {
    mockTask = Task(
      id: '1',
      title: 'Test Task',
      description: 'Test Description',
      dueDate: DateTime.now(),
      isCompleted: false,
      createdAt: DateTime.now(),
    );
    mockOnToggleComplete = () {};
    mockOnDelete = () {};
    mockOnEdit = () {};
  });

  testWidgets('TaskListItem displays task information correctly', (
    WidgetTester tester,
  ) async {
    final taskWithDueDate = mockTask.copyWith(dueDate: DateTime.now());

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TaskListItem(
            task: taskWithDueDate,
            onToggleComplete: mockOnToggleComplete,
            onDelete: mockOnDelete,
            onEdit: mockOnEdit,
          ),
        ),
      ),
    );

    // Verify task title is displayed
    expect(find.text('Test Task'), findsOneWidget);

    // Verify task description is displayed
    expect(find.text('Test Description'), findsOneWidget);

    // Verify checkbox is present and unchecked
    expect(find.byType(Checkbox), findsOneWidget);
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, false);

    // Verify delete button is present
    expect(find.byIcon(Icons.delete), findsOneWidget);
  });

  testWidgets('TaskListItem shows strikethrough for completed tasks', (
    WidgetTester tester,
  ) async {
    final completedTask = mockTask.copyWith(isCompleted: true);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TaskListItem(
            task: completedTask,
            onToggleComplete: mockOnToggleComplete,
            onDelete: mockOnDelete,
            onEdit: mockOnEdit,
          ),
        ),
      ),
    );

    // Verify checkbox is checked
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, true);

    // Verify title has strikethrough
    final titleFinder = find.text('Test Task');
    final titleWidget = tester.widget<Text>(titleFinder);
    expect(titleWidget.style?.decoration, TextDecoration.lineThrough);
  });

  testWidgets('TaskListItem handles empty description', (
    WidgetTester tester,
  ) async {
    final taskWithoutDescription = mockTask.copyWith(description: '');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TaskListItem(
            task: taskWithoutDescription,
            onToggleComplete: mockOnToggleComplete,
            onDelete: mockOnDelete,
            onEdit: mockOnEdit,
          ),
        ),
      ),
    );

    // Verify description is not displayed
    expect(find.text('Test Description'), findsNothing);
  });
}
