import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_sync/data/repository/task_repository_impl.dart';
import 'package:task_sync/domain/repositories/task_repository.dart';
import 'package:task_sync/domain/use_cases/base/base_use_case.dart';
import 'package:task_sync/domain/use_cases/task/all_tasks_use_case.dart';
import 'package:task_sync/domain/use_cases/task/create_task_use_case.dart';
import 'package:task_sync/domain/use_cases/task/delete_task_use_case.dart';
import 'package:task_sync/domain/use_cases/task/tasks_by_status_use_case.dart';
import 'package:task_sync/domain/use_cases/task/toggle_task_status_use_case.dart';
import 'package:task_sync/domain/use_cases/task/update_task_use_case.dart';
import 'package:task_sync/utils/app_constants/app_constants.dart';

import '../../../domain/entity/task.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<CreateTask>(_onCreateTask);
    on<UpdateDueDate>(_onUpdateDueDate);
    on<EditTaskIconTapEvent>(_onEditTaskIconTap);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<ToggleTaskStatus>(_onToggleTaskStatus);
    on<FilterByStatus>(_onFilterTasks);
    on<SortTasksByDueDate>(_onDueDateSorting);
    on<SortTasksByCreatedDate>(_onCreatedDateSorting);
  }

  TaskRepository get _taskRepository => TaskRepositoryImpl.instance;

  AllTasksUseCase get _allTasksUseCase => AllTasksUseCase(_taskRepository);

  CreateTaskUseCase get _createTaskUseCase =>
      CreateTaskUseCase(_taskRepository);

  DeleteTaskUseCase get _deleteTaskUseCase =>
      DeleteTaskUseCase(_taskRepository);

  TasksByStatusUseCase get _tasksByStatusUseCase =>
      TasksByStatusUseCase(_taskRepository);

  ToggleTaskStatusUseCase get _toggleTaskStatusUseCase =>
      ToggleTaskStatusUseCase(_taskRepository);

  UpdateTaskUseCase get _updateTaskUseCase =>
      UpdateTaskUseCase(_taskRepository);

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = await _allTasksUseCase.call(NoParams());
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onCreateTask(CreateTask event, Emitter<TaskState> emit) async {
    try {
      final task = Task(
        id: AppConstants.emptyString,
        title: event.title,
        description: event.description,
        dueDate: event.dueDate,
        createdAt: DateTime.now(),
      );
      await _createTaskUseCase.call(CreateTaskParams(task: task));
      add(LoadTasks());
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  FutureOr<void> _onUpdateDueDate(UpdateDueDate event, Emitter<TaskState> emit) {
    emit(UpdateDueDateState(event.dueDate));
    add(LoadTasks());
  }

  FutureOr<void> _onEditTaskIconTap(EditTaskIconTapEvent event, Emitter<TaskState> emit) {
    emit(ResetState());
    emit(EditTaskIconTapState(task: event.task));
  }

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    try {
      await _updateTaskUseCase.call(UpdateTaskParams(task: event.task));
      add(LoadTasks());
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    try {
      await _deleteTaskUseCase.call(DeleteTaskParams(id: event.id));
      add(LoadTasks());
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onToggleTaskStatus(
      ToggleTaskStatus event, Emitter<TaskState> emit) async {
    try {
      await _toggleTaskStatusUseCase.call(ToggleTaskStatusParams(id: event.id));
      add(LoadTasks());
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onFilterTasks(
      FilterByStatus event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = event.isCompleted != null
          ? await _tasksByStatusUseCase
              .call(GetTasksByStatusParams(isCompleted: event.isCompleted!))
          : await _allTasksUseCase.call(NoParams());
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  FutureOr<void> _onDueDateSorting(
      SortTasksByDueDate event, Emitter<TaskState> emit) {
    final tasks = event.tasks;
    tasks.sort((a, b) {
      final comparison = a.dueDate.compareTo(b.dueDate);
      return event.ascending ? comparison : -comparison;
    });
    emit(ResetState());
    emit(SortState(tasks));
  }

  FutureOr<void> _onCreatedDateSorting(
      SortTasksByCreatedDate event, Emitter<TaskState> emit) {
    final tasks = event.tasks;
    tasks.sort((a, b) {
      final comparison = a.createdAt.compareTo(b.createdAt);
      return event.ascending ? comparison : -comparison;
    });
    emit(ResetState());
    emit(SortState(tasks));
  }
}
