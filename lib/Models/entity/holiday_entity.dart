
import 'package:json_annotation/json_annotation.dart';

part 'holiday_entity.g.dart';

@JsonSerializable()
class HolidayEntity {
  @JsonKey(name : 'id')
  String? id;
  @JsonKey(name : 'holidayTitle')
  String? holidayTitle;
  @JsonKey(name : 'startDate')
  String? startDate;
  @JsonKey(name : 'endDate')
  String? endDate;


  HolidayEntity({this.id, this.holidayTitle, this.startDate, this.endDate});

  factory HolidayEntity.fromJson(Map<String, dynamic> json) =>
      _$HolidayEntityFromJson(json);


  Map<String, dynamic> toJson() => _$HolidayEntityToJson(this);

}