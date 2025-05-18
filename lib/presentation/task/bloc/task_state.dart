part of 'task_bloc.dart';

sealed class TaskState extends Equatable {
  const TaskState();
}

class TaskInitial extends TaskState {
  @override
  List<Object?> get props => [];
}

class TaskLoading extends TaskState {
  @override
  List<Object?> get props => [];
}

class TasksLoaded extends TaskState {
  final List<Task> tasks;

  const TasksLoaded(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

class TaskError extends TaskState {
  final String message;

  const TaskError(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateDueDateState extends TaskState {
  final DateTime dueDate;

  const UpdateDueDateState(this.dueDate);

  @override
  List<Object?> get props => [dueDate];
}

class SortState extends TaskState {
  final List<Task> tasks;

  const SortState(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

class ResetState extends TaskState {
  const ResetState();

  @override
  List<Object?> get props => [];
}

class EditTaskIconTapState extends TaskState {
  const EditTaskIconTapState({required this.task});

  final Task task;

  @override
  List<Object?> get props => [task];
}
