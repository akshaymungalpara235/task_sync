import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_sync/domain/entity/task.dart';
import 'package:task_sync/presentation/task/bloc/task_bloc.dart';
import 'package:task_sync/presentation/task/screen/widget/task_list_widget.dart';
import 'package:task_sync/presentation/task/screen/widget/task_form.dart';
import 'package:task_sync/utils/app_strings/app_strings.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> tasks = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: BlocListener<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TasksLoaded) {
            tasks.clear();
            tasks.addAll(state.tasks);
          } else if (state is EditTaskIconTapState) {
            _showTaskForm(context, task: state.task);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.appName),
            actions: [
              IconButton(
                onPressed: () {
                  _showFilterBottomSheet(context);
                },
                icon: const Icon(Icons.filter_list),
              ),
            ],
            bottom: const TabBar(
              tabs: [
                Tab(text: AppStrings.allTasks),
                Tab(text: AppStrings.pending),
                Tab(text: AppStrings.completed),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              const TaskListWidget(),
              TaskListWidget(filter: false),
              TaskListWidget(filter: true),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showTaskForm(context),
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  AppStrings.sortTasks,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              AppStrings.dueDateCaps,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      context.read<TaskBloc>().add(
                          SortTasksByDueDate(ascending: true, tasks: tasks));
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_upward),
                    label: const Text(AppStrings.ascending),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      context.read<TaskBloc>().add(
                          SortTasksByDueDate(ascending: false, tasks: tasks));
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_downward),
                    label: const Text(AppStrings.descending),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              AppStrings.createdDate,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      context.read<TaskBloc>().add(SortTasksByCreatedDate(
                          ascending: true, tasks: tasks));
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_upward),
                    label: const Text(AppStrings.ascending),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      context.read<TaskBloc>().add(SortTasksByCreatedDate(
                          ascending: false, tasks: tasks));
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_downward),
                    label: const Text(AppStrings.descending),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showTaskForm(BuildContext context, {Task? task}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text(
                  AppStrings.createNewTask,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TaskForm(
              initialDueDate: DateTime.now().add(const Duration(days: 1)),
              task: task,
              onSubmit: (title, description, dueDate) {
                if (task != null) {
                  final updatedTask = task.copyWith(
                      title: title, description: description, dueDate: dueDate);
                  context.read<TaskBloc>().add(UpdateTask(updatedTask));
                } else {
                  context.read<TaskBloc>().add(
                        CreateTask(
                          title: title,
                          description: description,
                          dueDate: dueDate ?? DateTime.now(),
                        ),
                      );
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
