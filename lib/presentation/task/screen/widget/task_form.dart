import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_sync/domain/entity/task.dart';
import 'package:task_sync/presentation/task/bloc/task_bloc.dart';
import 'package:task_sync/utils/app_constants/app_constants.dart';
import 'package:task_sync/utils/app_strings/app_strings.dart';

class TaskForm extends StatefulWidget {
  final Function(String title, String description, DateTime? dueDate) onSubmit;
  final String? initialTitle;
  final String? initialDescription;
  final DateTime initialDueDate;
  final Task? task;

  const TaskForm({
    super.key,
    required this.onSubmit,
    required this.initialDueDate,
    this.initialTitle,
    this.initialDescription,
    this.task,
  });

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _descriptionController =
        TextEditingController(text: widget.initialDescription);
    _dueDate = widget.initialDueDate;
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _dueDate = widget.task!.dueDate;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (context.mounted && picked != null && picked != _dueDate) {
      context.read<TaskBloc>().add(UpdateDueDate(picked));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: AppStrings.titleCaps,
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.pleaseEnterATitleMessage;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: AppStrings.descriptionCaps,
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              if(state is UpdateDueDateState) {
                _dueDate = state.dueDate;
              }
              return ListTile(
                title: Text(
                    '${AppStrings.dueDateCaps}: ${_dueDate!.toString().split(
                        AppConstants.space)[0]}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              );
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.onSubmit(
                  _titleController.text,
                  _descriptionController.text,
                  _dueDate,
                );
              }
            },
            child: const Text(AppStrings.saveTask),
          ),
        ],
      ),
    );
  }
}
