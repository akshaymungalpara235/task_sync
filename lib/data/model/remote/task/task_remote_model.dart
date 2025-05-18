import 'package:json_annotation/json_annotation.dart';
import 'package:task_sync/domain/entity/task.dart';
import 'package:task_sync/utils/app_constants/app_constants.dart';

part 'task_remote_model.g.dart';

@JsonSerializable()
class TaskRemoteModel {
  @JsonKey(name: AppConstants.id)
  String? id;

  @JsonKey(name: AppConstants.title)
  String? title;

  @JsonKey(name: AppConstants.description)
  String? description;

  @JsonKey(name: AppConstants.isCompleted)
  bool? isCompleted;

  @JsonKey(name: AppConstants.dueDate)
  DateTime? dueDate;

  @JsonKey(name: AppConstants.createdAt)
  DateTime? createdAt;

  TaskRemoteModel({
    this.id,
    this.title,
    this.description,
    this.isCompleted,
    this.dueDate,
    this.createdAt,
  });

  factory TaskRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$TaskRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskRemoteModelToJson(this);

  Task toTask() {
    return Task(
      id: id ?? AppConstants.emptyString,
      title: title ?? AppConstants.emptyString,
      description: description ?? AppConstants.emptyString,
      isCompleted: isCompleted ?? false,
      dueDate:
          dueDate != null ? DateTime.parse(dueDate.toString()) : DateTime.now(),
      createdAt: createdAt != null
          ? DateTime.parse(createdAt.toString())
          : DateTime.now(),
    );
  }
}
