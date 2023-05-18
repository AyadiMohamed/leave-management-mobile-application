import 'package:app_conge/Screens/history_screen.dart';
import 'package:app_conge/Screens/login_screen.dart';
import 'package:app_conge/Screens/main_screen.dart';
import 'package:app_conge/Screens/password_screen.dart';
import 'package:app_conge/Screens/request_history.dart';
import 'package:app_conge/Screens/request_leave.dart';
import 'package:app_conge/Screens/splach_screen.dart';
import 'package:app_conge/main.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:app_conge/Screens/profile_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Leave app',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              style: ButtonStyle( backgroundColor: MaterialStateProperty.all(Colors.green), ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyHomePage(0)));
                },
                child: Text('Main', style: TextStyle(color: Colors.white))),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
                child: Text('Profile', style: TextStyle(color: Colors.white))),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RequestLeave()));
                },
                child: Text('Request Leave',
                    style: TextStyle(color: Colors.white))),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
                child:
                    Text('Main Screen', style: TextStyle(color: Colors.white))),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HistoryScreen()));
                },
                child: Text('History', style: TextStyle(color: Colors.white))),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PasswordScreen()));
                },
                child: Text('Change Password',
                    style: TextStyle(color: Colors.white))),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SplashScreen()));
                },
                child: Text('Splach Screen',
                    style: TextStyle(color: Colors.white))),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child:
                    Text('Login Screen', style: TextStyle(color: Colors.white))),
                    ElevatedButton(
                onPressed: () {
                //  Navigator.of(context).push(
                    //  MaterialPageRoute(builder: (context) => RequestHistory()));
                },
                child:
                    Text('Leave details', style: TextStyle(color: Colors.white)))
          ],
        ),
      ),
    );
  }
}
