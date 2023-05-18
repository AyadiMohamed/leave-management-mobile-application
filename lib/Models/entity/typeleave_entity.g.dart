// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typeleave_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveTypeEntity _$LeaveTypeEntityFromJson(Map<String, dynamic> json) =>
    LeaveTypeEntity(
      id: json['id'] as String?,
      leaveTitle: json['leaveTitle'] as String?,
    );

Map<String, dynamic> _$LeaveTypeEntityToJson(LeaveTypeEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'leaveTitle': instance.leaveTitle,
    };
