import 'dart:async';

import 'package:app_conge/Screens/home_page.dart';
import 'package:app_conge/Screens/login_screen.dart';
import 'package:app_conge/Screens/main_screen.dart';
import 'package:app_conge/Utility/shared_preference.dart';
import 'package:app_conge/main.dart';
import 'package:app_conge/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../Models/user_local.dart';
import '../providers/leaves.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    UserPreferences().getStatus().then((value) { 
    if(value == null || value == false){
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen())));
    }else{
      UserPreferences().getUser().then((value) { 
        Provider.of<UserProvider>(context, listen: false).getUser(value.userId as String, value.token as String).then((value) {
            // final currentUser = Provider.of<UserProvider>(context, listen: false);
            // final leavesData = Provider.of<Leaves>(context, listen: false);
            // leavesData.getPosts(currentUser.user.userId as String);
            Timer(
            Duration(seconds: 2),
            () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyHomePage(0))));
        });
            
        });
      
    }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              new Color(0x2723F9).withOpacity(0.6),
              new Color(0x1CACBF).withOpacity(0.6),
              new Color(0x0EEB3E).withOpacity(0.6)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("assets/images/teamdev-logo.png"),
              width: 276,
              height: 214,
            ),
            Text(
              "Team work makes the dream work!",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: "Dangrek",
                color: Colors.black.withOpacity(0.53),
              ),
            ),
            SpinKitThreeInOut(
              size: 30,
              itemBuilder: (context, index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: index.isEven
                        ? Colors.blue
                        : Color.fromRGBO(32, 201, 151, 1),
                  ),
                );
              },
            ),
          ],
        )
      ],
    ));
  }
}
