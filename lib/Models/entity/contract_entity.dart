import 'package:json_annotation/json_annotation.dart';

part 'contract_entity.g.dart';

@JsonSerializable()
class ContractEntity {
  @JsonKey(name : 'id')
  String? id;
  @JsonKey(name : 'coefficient')
  int? coefficient;
  @JsonKey(name : 'title')
  String? title;
  @JsonKey(name : 'startDate')
  String? startDate;
  @JsonKey(name : 'endDate')
  String? endDate;
  @JsonKey(name : 'createdAt')
  String? createdAt;
  @JsonKey(name : 'status')
  String? status;
  @JsonKey(name : 'collaboratorId')
  String? collaboratorId;

  ContractEntity(
      {this.id,
      this.coefficient,
      this.title,
      this.startDate,
      this.endDate,
      this.createdAt,
      this.status,
      this.collaboratorId});

      factory ContractEntity.fromJson(Map<String, dynamic> json) =>
      _$ContractEntityFromJson(json);


  Map<String, dynamic> toJson() => _$ContractEntityToJson(this);

}