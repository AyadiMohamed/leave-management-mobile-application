import 'package:app_conge/Models/entity/user_entity.dart';
import 'package:app_conge/Utility/shared_preference.dart';
import 'package:flutter/cupertino.dart';

import '../Models/api_service.dart';
import '../Models/user_local.dart';

import 'package:dio/dio.dart' as dio;

enum PasswordStatus {
  NotChanging,
  Changing,
  Changed,
}

class UserProvider extends ChangeNotifier {
  PasswordStatus _passwordStatus = PasswordStatus.NotChanging;

  User _user = User();

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  PasswordStatus get passwordStatus => _passwordStatus;

  set passwordStatus(PasswordStatus value) {
    _passwordStatus = value;
     notifyListeners();
  }

  Future<Map<String, dynamic>> getUser(String id, String token) async {
    var result;

    ApiService apiService = ApiService(dio.Dio());
    try {
      final response = await apiService.getUser(id, 'Bearer $token');
      //print(' from user API ${response}');
      print('Getting user');
      var userToken;
      UserPreferences().getToken().then((value) => userToken = value);
      User currentUser = User(
          userId: response.id,
          firstname: response.firstName,
          lastname: response.lastName,
          email: response.email,
          phoneNumber: response.phoneNumber,
          birthday: response.birthday,
          roles: response.roles,
          earnedBalance: response.earnedBalance,
          //sickBalance: response.sickBalance,
          token: userToken);
      setUser(currentUser);
      result = {'status': true, 'message': 'Successful', 'user': currentUser};

      return result;
    } on dio.DioError catch (e) {
      if (e.response?.statusCode == 401) {
        print("Unathorized");

        result = {'status': false, 'message': 'Unauthorized'};
      } else {
        result = {'status': false, 'message': e.message};
        print(' this is the error of User ${e.response}');
      }
      return result;
    }
  }

   Future<Map<String, dynamic>> updatePassword(String id, String currentPassword, String newPassword, String confirmPassword ) async {
    var result;

     passwordStatus = PasswordStatus.Changing;
          notifyListeners();

    final Map<String, dynamic> passwordData = {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
      'confirmNewPassword': confirmPassword
    };

    ApiService apiService = ApiService(dio.Dio());
    var response;
    try {
      response = await apiService.updatePassword(id,passwordData);
      print('${response.toJson()}');
        User authUser = User(
          userId: response.id,
          firstname: response.firstName,
          lastname: response.lastName,
          email: response.email,
          phoneNumber: response.phoneNumber,
          birthday: response.birthday,
          roles: response.roles,
          earnedBalance: response.earnedBalance,
          //sickBalance: response.sickBalance,
          //token: userToken
        );
        passwordStatus = PasswordStatus.Changed;
        notifyListeners();
        result = {'status': true, 'message': 'Successful', 'user': authUser};
    } on dio.DioError catch (e) {
        passwordStatus = PasswordStatus.NotChanging;
        notifyListeners();
        result = {'status': false, 'message': e.response?.data['message']};
        print(' this is the error changing pass ${e.message} ${e.response?.data['message']}');
      }
    return result;
  }
}
