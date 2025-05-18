import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_sync/presentation/task/bloc/task_bloc.dart';
import 'package:task_sync/presentation/task/screen/widget/task_form.dart';

void main() {
  late Function(String, String, DateTime?) mockOnSubmit;

  setUp(() {
    mockOnSubmit = (title, description, dueDate) {};
  });

  testWidgets('TaskForm displays all required fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => TaskBloc(),
          child: Scaffold(
            body: TaskForm(
              initialDueDate: DateTime.now().add(Duration(days: 1)),
              onSubmit: mockOnSubmit,
            ),
          ),
        ),
      ),
    );

    final date = DateTime.now().add(Duration(days: 1)).toString().split(' ')[0];
    // Verify form fields are present
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
    expect(find.text("Due date: $date"), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('TaskForm validates required title field',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => TaskBloc(),
          child: Scaffold(
            body: TaskForm(
              initialDueDate: DateTime.now().add(Duration(days: 1)),
              onSubmit: mockOnSubmit,
            ),
          ),
        ),
      ),
    );

    // Try to submit without entering title
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify error message
    expect(find.text('Please enter a title'), findsOneWidget);
  });

  testWidgets('TaskForm submits with valid data', (WidgetTester tester) async {
    bool submitted = false;
    String submittedTitle = '';
    String submittedDescription = '';
    DateTime? submittedDueDate;

    final date = DateTime.now().add(Duration(days: 1));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => TaskBloc(),
          child: Scaffold(
            body: TaskForm(
              initialDueDate: date,
              onSubmit: (title, description, dueDate) {
                submitted = true;
                submittedTitle = title;
                submittedDescription = description;
                submittedDueDate = dueDate;
              },
            ),
          ),
        ),
      ),
    );

    // Enter title
    await tester.enterText(find.byType(TextFormField).first, 'Test Title');

    // Enter description
    await tester.enterText(find.byType(TextFormField).last, 'Test Description');

    // Submit form
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify submission
    expect(submitted, true);
    expect(submittedTitle, 'Test Title');
    expect(submittedDescription, 'Test Description');
    expect(submittedDueDate, date);
  });

  testWidgets('TaskForm initializes with provided values',
      (WidgetTester tester) async {
    const initialTitle = 'Initial Title';
    const initialDescription = 'Initial Description';
    final initialDueDate = DateTime.now();

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => TaskBloc(),
          child: Scaffold(
            body: TaskForm(
              onSubmit: mockOnSubmit,
              initialTitle: initialTitle,
              initialDescription: initialDescription,
              initialDueDate: initialDueDate,
            ),
          ),
        ),
      ),
    );

    // Verify initial values
    expect(find.text(initialTitle), findsOneWidget);
    expect(find.text(initialDescription), findsOneWidget);
    expect(
      find.text('Due date: ${initialDueDate.toString().split(' ')[0]}'),
      findsOneWidget,
    );
  });
}
