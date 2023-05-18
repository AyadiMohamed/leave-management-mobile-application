import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Models/api_service.dart';
import 'package:dio/dio.dart' as dio;

import '../Models/entity/logs_entity.dart';

enum LogsStatus { Exist, Loading, NotFound, Empty }

class Logs with ChangeNotifier {
  List<LogsEntity> _items = [];
  LogsStatus logStatus = LogsStatus.Empty;

  void setLogs(List<LogsEntity> logs) {
    logs.sort(
      (a, b) {
        return DateTime.parse(b.date as String)
            .compareTo(DateTime.parse(a.date as String));
      },
    );
    _items = logs;
    notifyListeners();
  }

  List<LogsEntity> get items {
    return [..._items];
  }

  Future<List<LogsEntity>> getLogs(String id) async {
    logStatus = LogsStatus.Loading;
    notifyListeners();
    ApiService apiService = ApiService(dio.Dio());
    try {
      print("Getting Logs");
      final response = await apiService.getLogs(id);
      setLogs(response);
      logStatus = LogsStatus.Exist;
      return response;
    } on dio.DioError catch (e) {
      if (e.response?.statusCode == 401) {
        print("Unathorized");
        //result = {'status': false, 'message': 'Unauthorized'};
      } else {
        //result = {'status': false, 'message': e.message};
        print(' This is the error ${e.message}');
      }
      logStatus = LogsStatus.NotFound;
      notifyListeners();
      return [];
    }
  }
}
