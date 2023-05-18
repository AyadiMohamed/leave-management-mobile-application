// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractEntity _$ContractEntityFromJson(Map<String, dynamic> json) =>
    ContractEntity(
      id: json['id'] as String?,
      coefficient: json['coefficient'] as int?,
      title: json['title'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      createdAt: json['createdAt'] as String?,
      status: json['status'] as String?,
      collaboratorId: json['collaboratorId'] as String?,
    );

Map<String, dynamic> _$ContractEntityToJson(ContractEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'coefficient': instance.coefficient,
      'title': instance.title,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'createdAt': instance.createdAt,
      'status': instance.status,
      'collaboratorId': instance.collaboratorId,
    };
