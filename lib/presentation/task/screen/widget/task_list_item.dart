import 'package:flutter/material.dart';
import 'package:task_sync/domain/entity/task.dart';
import 'package:task_sync/utils/app_constants/app_constants.dart';
import 'package:task_sync/utils/app_strings/app_strings.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final VoidCallback onToggleComplete;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskListItem({
    super.key,
    required this.task,
    required this.onToggleComplete,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (_) => onToggleComplete(),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.description.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(task.description),
            ],
            ...[
              const SizedBox(height: 4),
              Text(
                '${AppStrings.dueCaps}: ${task.dueDate.toString().split(AppConstants.space)[0]}',
                style: TextStyle(
                  color:
                      task.dueDate.isBefore(DateTime.now()) && !task.isCompleted
                          ? Colors.red
                          : Colors.grey,
                ),
              ),
            ],
          ],
        ),
        trailing: Wrap(
          children: [
            if (!task.isCompleted)
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: onEdit,
              ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
