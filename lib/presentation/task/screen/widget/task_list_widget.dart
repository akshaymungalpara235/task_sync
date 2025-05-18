import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_sync/presentation/task/bloc/task_bloc.dart';
import 'package:task_sync/presentation/task/screen/widget/task_list_item.dart';
import 'package:task_sync/utils/app_strings/app_strings.dart';

class TaskListWidget extends StatelessWidget {
  final bool? filter;

  const TaskListWidget({
    super.key,
    this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      buildWhen: (previous, current) =>
          current is TaskLoading ||
          current is TasksLoaded ||
          current is TaskError ||
          current is SortState,
      builder: (context, state) {
        if (state is TaskLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TasksLoaded || state is SortState) {
          var filteredTasks = [];
          if (state is TasksLoaded) {
            filteredTasks = filter == null
                ? state.tasks
                : state.tasks
                    .where((task) => task.isCompleted == filter)
                    .toList();
          } else if (state is SortState) {
            filteredTasks = filter == null
                ? state.tasks
                : state.tasks
                    .where((task) => task.isCompleted == filter)
                    .toList();
          }

          if (filteredTasks.isEmpty) {
            return Center(
              child: Text(
                filter == null
                    ? AppStrings.noTaskYetMessage
                    : filter == true
                        ? AppStrings.noCompletedTasksYetMessage
                        : AppStrings.noPendingTasksYetMessage,
                style: const TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: filteredTasks.length,
            itemBuilder: (context, index) {
              final task = filteredTasks[index];
              return TaskListItem(
                task: task,
                onToggleComplete: () {
                  context.read<TaskBloc>().add(ToggleTaskStatus(task.id));
                },
                onDelete: () {
                  context.read<TaskBloc>().add(DeleteTask(task.id));
                },
                onEdit: () {
                  context
                      .read<TaskBloc>()
                      .add(EditTaskIconTapEvent(task: task));
                },
              );
            },
          );
        } else if (state is TaskError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.message),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<TaskBloc>().add(LoadTasks());
                  },
                  child: const Text(AppStrings.retry),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
