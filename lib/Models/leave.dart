import 'package:flutter/foundation.dart';

class Leave {
  final String id;
  final String startDate;
  final String endDate;
  final String fullDate;
  final String type;
  //final int daysRequested;
  final String status;
  final String leaveDesc;
  //final String denialDesc;
  final String attachment;
  final String createdAt;
  //final String collaboratorId;

  Leave({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.type,
    //required this.daysRequested,
    required this.status,
    required this.leaveDesc,
    //required this.denialDesc,
    required this.attachment,
    required this.createdAt,
    //required this.collaboratorId
  }) : fullDate = '$startDate - $endDate';

  // factory Leave._(String id, String startDate, String endDate, String type, String status, String leaveDesc, String attachment, String createdAt){
  //     String fullDate = '$startDate - $endDate';
  //   return Leave(id: id, startDate: startDate, endDate: endDate, fullDate : fullDate,  type: type, status: status, leaveDesc: leaveDesc, attachment: attachment, createdAt: createdAt);

  //     }
}
