import 'package:json_annotation/json_annotation.dart';

part 'logs_entity.g.dart';

@JsonSerializable()
class LogsEntity {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'Date')
  String? date;
  @JsonKey(name: 'action')
  double? action;
  @JsonKey(name: 'collaboratorId')
  String? collaboratorId;

  LogsEntity({this.id, this.date, this.action, this.collaboratorId});

  factory LogsEntity.fromJson(Map<String, dynamic> json) =>
      _$LogsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LogsEntityToJson(this);
}
