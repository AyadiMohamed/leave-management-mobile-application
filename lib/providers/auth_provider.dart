import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../Models/api_service.dart';
import '../Models/user_local.dart';
import '../Utility/shared_preference.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider extends ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;

  set loggedInStatus(Status value) {
    _loggedInStatus = value;
    
  }

  Status get registeredInStatus => _registeredInStatus;

  set registeredInStatus(Status value) {
    _registeredInStatus = value;
  }

  notify() {
    notifyListeners();
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;

    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    ApiService apiService = ApiService(dio.Dio());
    var response;
    try {
      response = await apiService.login(loginData);
      print('${response.toJson()}');
      if (response.accessToken != '') {
        //   final Map<String, dynamic> responseData = json.decode(response.body);

        //   print(responseData);

        //   var userData = responseData['Content'];

        //   User authUser = User.fromJson(userData);
        User authUser = User(
          userId: response.userEntity?.id,
          firstname: response.userEntity?.firstName,
          lastname: response.userEntity?.lastName,
          email: response.userEntity?.email,
          phoneNumber: response.userEntity?.phoneNumber,
          birthday: response.userEntity?.birthday,
          roles: response.userEntity?.roles,
          earnedBalance: response.userEntity?.earnedBalance,
          //sickBalance: response.userEntity?.sickBalance,
          token: response.accessToken,
        );
        UserPreferences().saveUser(authUser);
        _loggedInStatus = Status.LoggedIn;
        notifyListeners();

        result = {'status': true, 'message': 'Successful', 'user': authUser};
      } else {
        _loggedInStatus = Status.NotLoggedIn;
        notifyListeners();
        result = {'status': false, 'message': 'Failed', 'user': ''};
      }
    } on dio.DioError catch (e) {
      if (e.response?.statusCode == 401) {
        //print("Unathorized");
        _loggedInStatus = Status.NotLoggedIn;
        notifyListeners();
        result = {'status': false, 'message': 'Unauthorized'};
      } else {
        _loggedInStatus = Status.NotLoggedIn;
        notifyListeners();
         result = {'status': false, 'message': e.message};
        print(' This is the error ${e.message}');
      }
    }
    return result;
  }

  static onError(error) {
    print('the error is ${error.detail}');
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
