import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Models/api_service.dart';
import 'package:dio/dio.dart' as dio;

import '../Models/entity/contract_entity.dart';

enum ContractStatus { Exist, Loading, NotFound }

class Contracts with ChangeNotifier {
  List<ContractEntity> _items = [];
  ContractStatus contractStatus = ContractStatus.NotFound;

  void setContract(List<ContractEntity> contracts) {
    _items = contracts;
    notifyListeners();
  }

  List<ContractEntity> get items {
    // if(_showFavoritesOnly){
    //   return _items.where((element) => element.isFavorite).toList();
    // }else{
    return [..._items];
  }


  Future<List<ContractEntity>> getUserContracts(String id) async {
    contractStatus = ContractStatus.Loading;
    notifyListeners();
    ApiService apiService = ApiService(dio.Dio());
    try {
      print("Getting contracts");
      final response = await apiService.getUserContracts(id);
      //setContracts(response);
      return response;
    } on dio.DioError catch (e) {
      if (e.response?.statusCode == 401) {
        print("Unathorized");
        //result = {'status': false, 'message': 'Unauthorized'};
      } else {
        //result = {'status': false, 'message': e.message};
        print(' This is the error ${e.message}');
      }
      contractStatus = ContractStatus.NotFound;
      notifyListeners();
      return [];
    }
  }

  void setContracts(List<ContractEntity> userContracts) {
    // if(_showFavoritesOnly){
      // return _items.where((element) => element.isFavorite).toList();
    // }else{
  }
}
