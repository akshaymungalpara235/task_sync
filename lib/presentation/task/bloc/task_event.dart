part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();
}

class LoadTasks extends TaskEvent {
  @override
  List<Object?> get props => [];
}

class CreateTask extends TaskEvent {
  final String title;
  final String description;
  final DateTime dueDate;

  const CreateTask({
    required this.title,
    required this.description,
    required this.dueDate,
  });

  @override
  List<Object?> get props => [title, description, dueDate];
}

class UpdateDueDate extends TaskEvent {
  final DateTime dueDate;

  const UpdateDueDate(this.dueDate);

  @override
  List<Object?> get props => [dueDate];
}

class UpdateTask extends TaskEvent {
  final Task task;

  const UpdateTask(this.task);

  @override
  List<Object?> get props => [task];
}

class DeleteTask extends TaskEvent {
  final String id;

  const DeleteTask(this.id);

  @override
  List<Object?> get props => [id];
}

class ToggleTaskStatus extends TaskEvent {
  final String id;

  const ToggleTaskStatus(this.id);

  @override
  List<Object?> get props => [id];
}

class FilterByStatus extends TaskEvent {
  final bool? isCompleted;

  const FilterByStatus({this.isCompleted});

  @override
  List<Object?> get props => [isCompleted];
}

class SortTasksByDueDate extends TaskEvent {
  final bool ascending;
  final List<Task> tasks;

  const SortTasksByDueDate({required this.ascending, required this.tasks});

  @override
  List<Object?> get props => [ascending];
}

class SortTasksByCreatedDate extends TaskEvent {
  final bool ascending;
  final List<Task> tasks;

  const SortTasksByCreatedDate({required this.ascending, required this.tasks});

  @override
  List<Object?> get props => [ascending];
}

class EditTaskIconTapEvent extends TaskEvent {
  const EditTaskIconTapEvent({required this.task});

  final Task task;

  @override
  List<Object?> get props => [task];
}
