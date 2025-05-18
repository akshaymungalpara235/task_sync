// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskRemoteModel _$TaskRemoteModelFromJson(Map<String, dynamic> json) =>
    TaskRemoteModel(
      id: json['id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      isCompleted: json['is_completed'] as bool?,
      dueDate: json['due_date'] == null
          ? null
          : DateTime.parse(json['due_date'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$TaskRemoteModelToJson(TaskRemoteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'is_completed': instance.isCompleted,
      'due_date': instance.dueDate?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
    };
