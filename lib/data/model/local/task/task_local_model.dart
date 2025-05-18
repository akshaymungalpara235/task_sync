import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:task_sync/domain/entity/task.dart';
import 'package:task_sync/utils/app_constants/app_constants.dart';

part 'task_local_model.g.dart';

@JsonSerializable()
class TaskLocalModel extends Equatable {
  @JsonKey(name: AppConstants.id)
  final String id;

  @JsonKey(name: AppConstants.title)
  final String title;

  @JsonKey(name: AppConstants.description)
  final String description;

  @JsonKey(name: AppConstants.isCompleted)
  final bool isCompleted;

  @JsonKey(name: AppConstants.dueDate)
  final DateTime dueDate;

  @JsonKey(name: AppConstants.createdAt)
  final DateTime createdAt;

  const TaskLocalModel({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.dueDate,
    required this.createdAt,
  });

  Task toTask() {
    return Task(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
      dueDate: dueDate,
      createdAt: createdAt,
    );
  }

  factory TaskLocalModel.fromJson(Map<String, dynamic> json) => TaskLocalModel(
        id: json[AppConstants.id] as String,
        title: json[AppConstants.title] as String,
        description: json[AppConstants.description] as String,
        isCompleted: json[AppConstants.isCompleted] == 1 ? true : false,
        dueDate: json[AppConstants.dueDate].toString().isNotEmpty
            ? DateTime.parse(json[AppConstants.dueDate])
            : DateTime.now(),
        createdAt: json[AppConstants.createdAt].toString().isNotEmpty
            ? DateTime.parse(json[AppConstants.createdAt])
            : DateTime.now(),
      );

  Map<String, dynamic> toJson() => _$TaskLocalModelToJson(this);

  TaskLocalModel copyWith({
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? dueDate,
  }) {
    return TaskLocalModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt,
    );
  }

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
