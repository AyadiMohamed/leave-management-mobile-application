// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logs_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogsEntity _$LogsEntityFromJson(Map<String, dynamic> json) => LogsEntity(
      id: json['id'] as String?,
      date: json['Date'] as String?,
      action: (json['action'] as num?)?.toDouble(),
      collaboratorId: json['collaboratorId'] as String?,
    );

Map<String, dynamic> _$LogsEntityToJson(LogsEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'Date': instance.date,
      'action': instance.action,
      'collaboratorId': instance.collaboratorId,
    };
