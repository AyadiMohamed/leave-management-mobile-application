// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holiday_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HolidayEntity _$HolidayEntityFromJson(Map<String, dynamic> json) =>
    HolidayEntity(
      id: json['id'] as String?,
      holidayTitle: json['holidayTitle'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
    );

Map<String, dynamic> _$HolidayEntityToJson(HolidayEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'holidayTitle': instance.holidayTitle,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };
