import 'package:flutter_test/flutter_test.dart';
import 'package:task_sync/data/model/local/task/task_local_model.dart';

void main() {
  group('TaskLocalModel', () {
    test('creates a task with all fields', () {
      final now = DateTime.now();
      final task = TaskLocalModel(
        id: '1',
        title: 'Test Task',
        description: 'Test Task Description',
        dueDate: now,
        isCompleted: false,
        createdAt: now,
      );

      expect(task.id, '1');
      expect(task.title, 'Test Task');
      expect(task.description, 'Test Task Description');
      expect(task.dueDate, now);
      expect(task.isCompleted, false);
      expect(task.createdAt, now);
    });

    test('creates a task with optional fields', () {
      final now = DateTime.now();
      final task = TaskLocalModel(
        id: '1',
        title: 'Test Task',
        description: 'Test Task Description',
        dueDate: now,
        isCompleted: false,
        createdAt: now,
      );

      expect(task.id, '1');
      expect(task.title, 'Test Task');
      expect(task.description, 'Test Task Description');
      expect(task.dueDate, now);
      expect(task.isCompleted, false);
      expect(task.createdAt, now);
    });

    test('creates a copy with updated fields', () {
      final now = DateTime.now();
      final task = TaskLocalModel(
        id: '1',
        title: 'Updated Test Task',
        description: 'Updated Test Description',
        dueDate: now,
        isCompleted: false,
        createdAt: now,
      );

      final updatedTask = task.copyWith(
        title: 'Updated Task',
        isCompleted: true,
      );

      expect(updatedTask.id, '1');
      expect(updatedTask.title, 'Updated Task');
      expect(updatedTask.description, 'Updated Test Description');
      expect(updatedTask.dueDate, now);
      expect(updatedTask.isCompleted, true);
      expect(updatedTask.createdAt, now);
    });

    test('creates a copy with null fields', () {
      final now = DateTime.now();
      final task = TaskLocalModel(
        id: '1',
        title: 'Test Task',
        description: 'Test Task Description',
        dueDate: now,
        isCompleted: false,
        createdAt: now,
      );

      final updatedTask = task.copyWith(
        description: null,
        dueDate: null,
      );

      expect(updatedTask.id, '1');
      expect(updatedTask.title, 'Test Task');
      expect(updatedTask.description, 'Test Task Description');
      expect(updatedTask.dueDate, now);
      expect(updatedTask.isCompleted, false);
      expect(updatedTask.createdAt, now);
    });

    test('converts to and from JSON', () {
      final now = DateTime.now();
      final task = TaskLocalModel(
        id: '1',
        title: 'Test Task',
        description: 'Test Description',
        dueDate: now,
        isCompleted: false,
        createdAt: now,
      );

      final json = task.toJson();
      final fromJson = TaskLocalModel.fromJson(json);

      expect(fromJson.id, task.id);
      expect(fromJson.title, task.title);
      expect(fromJson.description, task.description);
      expect(fromJson.dueDate.millisecondsSinceEpoch, task.dueDate.millisecondsSinceEpoch);
      expect(fromJson.isCompleted, task.isCompleted);
      expect(fromJson.createdAt.millisecondsSinceEpoch, task.createdAt.millisecondsSinceEpoch);
    });

    test('converts to and from JSON with null fields', () {
      final now = DateTime.now();
      final task = TaskLocalModel(
        id: '1',
        title: 'Test Task',
        description: "Test Task Description",
        dueDate: now,
        isCompleted: false,
        createdAt: now,
      );

      final json = task.toJson();
      final fromJson = TaskLocalModel.fromJson(json);

      expect(fromJson.id, task.id);
      expect(fromJson.title, task.title);
      expect(fromJson.description, task.description);
      expect(fromJson.dueDate, task.dueDate);
      expect(fromJson.isCompleted, task.isCompleted);
      expect(fromJson.createdAt.millisecondsSinceEpoch, task.createdAt.millisecondsSinceEpoch);
    });
  });
} 