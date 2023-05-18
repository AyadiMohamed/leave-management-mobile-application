import 'package:app_conge/Models/leave.dart';
import 'package:flutter/material.dart';

import '../Models/api_service.dart';
import '../Models/entity/leave_entity.dart';
import 'package:dio/dio.dart' as dio;

import '../Models/entity/typeleave_entity.dart';

enum LeavesStatus { Exist, Loading, NotFound }

class Leaves with ChangeNotifier {
  List<LeaveEntity> _items = [];
  List<LeaveTypeEntity> _types = [];
  LeavesStatus leaveStatus = LeavesStatus.NotFound;

  Future<List<LeaveEntity>> getLeaves(String id) async {
    leaveStatus = LeavesStatus.Loading;
    notifyListeners();
    ApiService apiService = ApiService(dio.Dio());
    try {
      print("Getting leaves");
      final response = await apiService.getLeaves(id);
      setLeaves(response.reversed.toList());
      leaveStatus = LeavesStatus.Exist;
      notifyListeners();
      print('${response.length}');
      return response;
    } on dio.DioError catch (e) {
      if (e.response?.statusCode == 401) {
        print("Unathorized");
        //result = {'status': false, 'message': 'Unauthorized'};
      } else {
        //result = {'status': false, 'message': e.message};
        print(' This is the error ${e.message}');
      }
      leaveStatus = LeavesStatus.NotFound;
      notifyListeners();
      return [];
    }
  }

  Future<List<LeaveTypeEntity>> getLeaveTypes() async {
    ApiService apiService = ApiService(dio.Dio());
    try {
      final response = await apiService.getTypes();
      setTypes(response);
      return response;
    } on dio.DioError catch (e) {
      if (e.response?.statusCode == 401) {
        print("Unathorized");

        //result = {'status': false, 'message': 'Unauthorized'};
      } else {
        //result = {'status': false, 'message': e.message};
        print(' this is the error ${e.message}');
      }
      return [];
    }
  }

  Future<Map<String, dynamic>> addLeave(String id, LeaveEntity leave) async {
    var result;

    ApiService apiService = ApiService(dio.Dio());

    final Map<String, dynamic> leaverequest = {
      "endDate": leave.endDate,
      "type": leave.type,
      "daysRequested": leave.daysRequested,
      "status": leave.status,
      "leaveDesc": leave.leaveDesc,
      "denialDesc": leave.denialDesc,
      "attachment": leave.attachment,
      "startDate": leave.startDate,
      "sentBy": leave.sentBy
    };
    try {
      final response = await apiService.addLeave(id, leaverequest);
      result = {
        'status': true,
        'message': 'Successfully added ',
        'leave': response
      };
      return result;
    } on dio.DioError catch (e) {
      if (e.response?.statusCode == 401) {
        print("Unathorized");
      } else {
        print(' this is the error ${e.message} ${e.response?.statusMessage}');
      }
      result = {
        'status': false,
        'message': '${e.response?.statusMessage}',
        'leave': ''
      };
      return result;
    }
  }

  Future<List<LeaveEntity>> getLeavesByDate(
      String id, String start, String end) async {
    leaveStatus = LeavesStatus.Loading;
    notifyListeners();
    ApiService apiService = ApiService(dio.Dio());
    try {
      print("Getting filtred leaves by date ");
      final response = await apiService.getLeavesByDate(id, start, end);
      setLeaves(response.reversed.toList());
      leaveStatus = LeavesStatus.Exist;
      notifyListeners();
      print('${response.length}');
      return response;
    } on dio.DioError catch (e) {
      if (e.response?.statusCode == 401) {
        print("Unathorized");
      } else {
        print(' this is the error ${e.message}');
      }
      leaveStatus = LeavesStatus.NotFound;
      notifyListeners();
      return [];
    }
  }

  Future<List<LeaveEntity>> getLeavesByStatus(String id, String status) async {
    ApiService apiService = ApiService(dio.Dio());
    try {
      print("Getting filtred leaves by status ");
      final response = await apiService.getLeavesByStatus(id, status);
      setLeaves(response.reversed.toList());
      print('${response.length}');
      return response;
    } on dio.DioError catch (e) {
      if (e.response?.statusCode == 401) {
        print("Unathorized");
      } else {
        print(' this is the error ${e.message}');
      }
      return [];
    }
  }

  void setLeaves(List<LeaveEntity> leaves) {
    _items = leaves;
    notifyListeners();
  }

  void setTypes(List<LeaveTypeEntity> types) {
    _types = types;
    notifyListeners();
  }

  List<LeaveEntity> get items {
    // if(_showFavoritesOnly){
    //   return _items.where((element) => element.isFavorite).toList();
    // }else{
    return [..._items];
  }

  List<LeaveTypeEntity> get types {
    // if(_showFavoritesOnly){
    //   return _items.where((element) => element.isFavorite).toList();
    // }else{
    return [..._types];
  }

  List<LeaveEntity> get approvedItems {
    // if(_showFavoritesOnly){
    //   return _items.where((element) => element.isFavorite).toList();
    // }else{
    return items.where((element) => element.status == 'approved').toList();
  }

  List<LeaveEntity> get refusedItems {
    return items.where((element) => element.status == 'declined').toList();
  }

  List<LeaveEntity> get pendingItems {
    return items
        .where((element) =>
            element.status == 'pending' || element.status == 'adminproposition')
        .toList();
  }
}
