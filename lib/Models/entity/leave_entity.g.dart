// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveEntity _$LeaveEntityFromJson(Map<String, dynamic> json) => LeaveEntity(
      id: json['id'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      type: json['type'] as String?,
      daysRequested: json['daysRequested'] as int?,
      status: json['status'] as String?,
      leaveDesc: json['leaveDesc'] as String?,
      denialDesc: json['denialDesc'] as String?,
      attachment: json['attachment'] as String?,
      createdAt: json['createdAt'] as String?,
      collaboratorId: json['collaboratorId'] as String?,
      sentBy: json['sentBy'] as String?,
    );

Map<String, dynamic> _$LeaveEntityToJson(LeaveEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'type': instance.type,
      'daysRequested': instance.daysRequested,
      'status': instance.status,
      'leaveDesc': instance.leaveDesc,
      'denialDesc': instance.denialDesc,
      'attachment': instance.attachment,
      'createdAt': instance.createdAt,
      'collaboratorId': instance.collaboratorId,
      'sentBy': instance.sentBy,
    };
