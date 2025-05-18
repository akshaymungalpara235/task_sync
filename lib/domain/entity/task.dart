import 'package:equatable/equatable.dart';
import 'package:task_sync/data/model/local/task/task_local_model.dart';
import 'package:task_sync/data/model/remote/task/task_remote_model.dart';
import 'package:task_sync/utils/app_constants/app_constants.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime dueDate;
  final DateTime createdAt;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.dueDate,
    required this.createdAt,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? dueDate,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  TaskRemoteModel toTaskRemoteModel() {
    return TaskRemoteModel(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
      dueDate: dueDate,
      createdAt: createdAt,
    );
  }

  TaskLocalModel toTaskLocalModel() {
    return TaskLocalModel(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
      dueDate: dueDate,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
        AppConstants.id: id,
        AppConstants.title: title,
        AppConstants.description: description,
        AppConstants.isCompleted: isCompleted ? 1 : 0,
        AppConstants.dueDate: dueDate.toIso8601String(),
        AppConstants.createdAt: createdAt.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        isCompleted,
        dueDate,
        createdAt,
      ];
}
