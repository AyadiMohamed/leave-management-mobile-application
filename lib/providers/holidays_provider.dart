import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Models/api_service.dart';
import 'package:dio/dio.dart' as dio;

import '../Models/entity/holiday_entity.dart';

enum HolidayStatus { Exist, Loading, NotFound }

class Holidays with ChangeNotifier {
  List<HolidayEntity> _items = [];
  List<HolidayEntity> _itemsForUi = [];
  HolidayStatus holidayStatus = HolidayStatus.NotFound;

  void setholiday(List<HolidayEntity> holidays) {
    _items = holidays;
    notifyListeners();
  }

  List<HolidayEntity> get items {
    // if(_showFavoritesOnly){
    //   return _items.where((element) => element.isFavorite).toList();
    // }else{
    return [..._items];
  }

  List<HolidayEntity> get itemsForUi {
    // if(_showFavoritesOnly){
    //   return _items.where((element) => element.isFavorite).toList();
    // }else{
    return [..._itemsForUi];
  }

  Future<List<HolidayEntity>> getRecentHolidays() async {
    holidayStatus = HolidayStatus.Loading;
    notifyListeners();
    ApiService apiService = ApiService(dio.Dio());
    try {
      print("Getting holiday");
      final response = await apiService.getHolidays();
      setSortedHolidays(response);
      return response;
    } on dio.DioError catch (e) {
      if (e.response?.statusCode == 401) {
        print("Unathorized");
        //result = {'status': false, 'message': 'Unauthorized'};
      } else {
        //result = {'status': false, 'message': e.message};
        print(' This is the error ${e.message}');
      }
      holidayStatus = HolidayStatus.NotFound;
      notifyListeners();
      return [];
    }
  }

  void setSortedHolidays(List<HolidayEntity> sortedHolidays) {
    // if(_showFavoritesOnly){
    //   return _items.where((element) => element.isFavorite).toList();
    // }else{
    sortedHolidays.sort((a, b) {
      return DateTime.parse(a.startDate as String)
          .compareTo(DateTime.parse(b.startDate as String));
    });
    _itemsForUi = sortedHolidays;
    _items = sortedHolidays
        .where((element) =>
            DateTime.parse(element.startDate as String)
                .difference(DateTime.now())
                .inDays >=
            0)
        .toList();
    if (_items.isEmpty) {
      holidayStatus = HolidayStatus.NotFound;
      notifyListeners();
    } else {
      holidayStatus = HolidayStatus.Exist;
      notifyListeners();
    }
    notifyListeners();
  }
}
