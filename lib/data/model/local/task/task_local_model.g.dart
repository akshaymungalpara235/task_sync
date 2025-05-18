// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_local_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskLocalModel _$TaskLocalModelFromJson(Map<String, dynamic> json) =>
    TaskLocalModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isCompleted: json['is_completed'] as bool? ?? false,
      dueDate: DateTime.parse(json['due_date'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$TaskLocalModelToJson(TaskLocalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'is_completed': instance.isCompleted,
      'due_date': instance.dueDate.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
    };
