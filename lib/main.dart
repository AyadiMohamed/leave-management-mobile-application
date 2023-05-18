import 'package:app_conge/Screens/history_screen.dart';
import 'package:app_conge/Screens/home_page.dart';
import 'package:app_conge/Screens/main_screen.dart';
import 'package:app_conge/Screens/profile_screen.dart';
import 'package:app_conge/Screens/request_leave.dart';
import 'package:app_conge/Screens/splach_screen.dart';
import 'package:app_conge/providers/holidays_provider.dart';
import 'package:app_conge/providers/logs_provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Utility/shared_preference.dart';
import 'providers/auth_provider.dart';
import 'providers/leaves.dart';

import 'Screens/login_screen.dart';
import 'providers/user_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (context) => Leaves()),
      ChangeNotifierProvider(create: (_)=> AuthProvider()),
      ChangeNotifierProvider(create: (_)=> UserProvider()),
      ChangeNotifierProvider(create: (_)=> Holidays()),
      ChangeNotifierProvider(create: (_)=> Logs()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'app_conge',
        theme: ThemeData(
          primaryColor: Color(0xff2E94B5),
          //primarySwatch: Colors.lightBlue,
          colorScheme: ColorScheme.light(
              primary: const Color(0xff2E94B5).withOpacity(0.7)),
          accentColor: Color(0xff005eab),
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
        ),
        home: SplashScreen(),
        routes: {
          // '/': (ctx) => HomePage(),
          HistoryScreen.routeName: (ctx) => HistoryScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          MyHomePage.routeName: (context) => MyHomePage(0),
        }, //ProfileScreen()//MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const routeName = '/Main';
  int fromMain;
  MyHomePage(this.fromMain);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var currentIndex = 2;
  final screens = [
    HistoryScreen(),
    MainScreen(),
    MainScreen(),
    ProfileScreen(),
    //RequestLeave(),
  ];
  void logoutt() {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.INFO_REVERSED,
            animType: AnimType.SCALE,
            headerAnimationLoop: false,
            title: 'Logout',
            desc: 'Are you sure',
            body: Center(
              child: Column(
                children: [
                  Text(
                    'Logout',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Container(
                    height: 30,
                  ),
                  Text(
                    'Are you sure',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            btnCancelOnPress: () {
              
            },
            btnOkOnPress: () {
              UserPreferences().removeUser();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false);
            },
            btnCancelColor: Theme.of(context).primaryColor,
            btnOkColor: Theme.of(context).primaryColor)
        .show();
  }

  @override
  Widget build(BuildContext context) {
   UserPreferences().getStatus().then((value) => print(value));
    if (widget.fromMain == 1) {
      setState(() {
        currentIndex = 3;
        widget.fromMain = 0;
      });}
       if (widget.fromMain == 2) {
      setState(() {
        currentIndex = 0;
        widget.fromMain = 0;
      });
    }
    return Scaffold(
      // body: IndexedStack(
      //   index: currentIndex,
      //   children: screens,
      // ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => {
          if (index == 4)
            {logoutt()}
          else
            {setState(() => currentIndex = index)}
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Color(0xff2E94B5).withOpacity(0.5),
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
      ),
    );
  }
}
