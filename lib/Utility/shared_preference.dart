
import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

import '../Models/user_local.dart';

class UserPreferences {

  void init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('exist', true);
  }

  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('userId',user.userId as String);
    prefs.setString('firstname',user.firstname as String);
    prefs.setString('lastname',user.lastname as String);
    prefs.setString('email',user.email as String);
    prefs.setString('birthday',user.birthday as String);
    prefs.setString('phoneNumber',user.phoneNumber as String);
    prefs.setStringList('roles',user.roles as List<String>);
    prefs.setDouble('earnedBalance',user.earnedBalance as double);
    //prefs.setInt('sickBalance',user.sickBalance as int);
    prefs.setString('token',user.token as String);
    prefs.setBool('exist', true);

    return prefs.commit();

  }

  Future<User> getUser ()  async {
   final SharedPreferences prefs = await SharedPreferences.getInstance();

   String? userId = prefs.getString("userId");
   String? firstname = prefs.getString("firstname");
   String? lastname = prefs.getString("lastname");
   String? email = prefs.getString("email");
   String? birthday = prefs.getString("birthday");
   String? phoneNumber = prefs.getString("phoneNumber");
   List<String>? roles = prefs.getStringList("roles");
   double? earnedBalance = prefs.getDouble("earnedBalance");
   //int? sickBalance = prefs.getInt("sickBalance");
   String? token = prefs.getString("token");

   return User(
       userId: userId,
       firstname: firstname,
       email: email,
       phoneNumber: phoneNumber,
       roles: roles,
       birthday: birthday,
       earnedBalance: earnedBalance,
       //sickBalance: sickBalance,
       lastname: lastname, 
       token: token);

  }

  void removeUser() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    prefs.setBool('exist', false);
    prefs.remove('userId');
    prefs.remove('firstname');
    prefs.remove('lastname');
    prefs.remove('phoneNumber');
    prefs.remove('birthday');
    prefs.remove('roles');
    prefs.remove('earnedBalance');
    //prefs.remove('sickBalance');
    prefs.remove('token');
    

  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token;
  }

  Future<bool?> getStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? status = prefs.getBool("exist");
    return status;
  }



  

}