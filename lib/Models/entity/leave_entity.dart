

import 'package:json_annotation/json_annotation.dart';

part 'leave_entity.g.dart';

@JsonSerializable()
class LeaveEntity{
  @JsonKey(name : 'id')
   String? id;
   @JsonKey(name : 'startDate')
   String? startDate;
   @JsonKey(name : 'endDate')
   String? endDate;
   @JsonKey(name : 'type')
   String? type;
   @JsonKey(name : 'daysRequested')
   int? daysRequested;
   @JsonKey(name : 'status')
   String? status;
   @JsonKey(name : 'leaveDesc')
   String? leaveDesc;
   @JsonKey(name : 'denialDesc')
   String? denialDesc;
   @JsonKey(name : 'attachment')
   String? attachment;
   @JsonKey(name : 'createdAt')
   String? createdAt;
   @JsonKey(name : 'collaboratorId')
   String? collaboratorId;
   @JsonKey(name : 'sentBy')
   String? sentBy;

   LeaveEntity(
      {this.id,
      this.startDate,
      this.endDate,
      this.type,
      this.daysRequested,
      this.status,
      this.leaveDesc,
      this.denialDesc,
      this.attachment,
      this.createdAt,
      this.collaboratorId, 
      this.sentBy
      });

        factory LeaveEntity.fromJson(Map<String, dynamic> json) =>
      _$LeaveEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveEntityToJson(this);
   


} 