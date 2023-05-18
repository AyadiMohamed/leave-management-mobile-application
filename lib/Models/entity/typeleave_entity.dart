import 'package:json_annotation/json_annotation.dart';

part 'typeleave_entity.g.dart';

@JsonSerializable()
class LeaveTypeEntity {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'leaveTitle')
  String? leaveTitle;

  LeaveTypeEntity({this.id, this.leaveTitle});

  factory LeaveTypeEntity.fromJson(Map<String, dynamic> json) =>
      _$LeaveTypeEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveTypeEntityToJson(this);
}
