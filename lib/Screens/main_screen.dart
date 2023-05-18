import 'package:app_conge/Screens/balance_log_screen.dart';
import 'package:app_conge/Screens/history_screen.dart';
import 'package:app_conge/Screens/holidays_list.dart';
import 'package:app_conge/Screens/profile_screen.dart';
import 'package:app_conge/Utility/shared_preference.dart';
import 'package:app_conge/Widgets/leave_item.dart';
import 'package:app_conge/main.dart';
import 'package:app_conge/providers/holidays_provider.dart';
import 'package:app_conge/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/leaves.dart';
import 'request_leave.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    UserPreferences().getUser().then((value) {
      //Provider.of<Leaves>(context, listen: false).getPosts(value.userId as String);
      Provider.of<Leaves>(context, listen: false).getLeavesByDate(
        value.userId as String,
        DateFormat('yyyy-MM-dd').format(DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day - 7)),
        DateFormat('yyyy-MM-dd').format(DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 7)),
      );
      Provider.of<Holidays>(context, listen: false).getRecentHolidays();
      Provider.of<UserProvider>(context, listen: false)
          .getUser(value.userId as String, value.token as String);
    });
    // final leavesData = Provider.of<Leaves>(context);
    // final leaves = leavesData.items;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                  //color: Color(0xff412EB5).withOpacity(0.7)
                  color: Color(0xff2E94B5).withOpacity(0.7)),
              height: 260,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 35, left: 35, right: 35),
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => MyHomePage(1)));
                          },
                          child: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://cdn.pixabay.com/photo/2017/02/23/13/05/avatar-2092113_960_720.png'),
                            radius: 33,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15, top: 8),
                          child: Consumer<UserProvider>(
                            builder: (context, value, child) => Text(
                              'Welcome, ${value.user.firstname}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 21),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18, left: 33),
                    child: Text(
                      'Your Balance ',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => BalanceLogScreen()));
                          },
                          child: Container(
                            width: 130,
                            height: 100,
                            color: Colors.white.withOpacity(0.1),
                            child: Padding(
                              padding: const EdgeInsets.all(7),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Earned',
                                    style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                  Consumer<UserProvider>(
                                    builder: (context, value, child) => Text(
                                      '${value.user.earnedBalance}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 45,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Days',
                                    style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Consumer<Holidays>(builder: (context, value, child) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HolidaysList()));
                            },
                            child: Container(
                              width: 130,
                              height: 100,
                              color: Colors.white.withOpacity(0.1),
                              child: Padding(
                                padding: const EdgeInsets.all(7),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Upcoming Holiday',
                                      style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                      ),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.contain,
                                      child: value.holidayStatus ==
                                              HolidayStatus.Loading
                                          ? CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : Text(
                                              value.holidayStatus ==
                                                      HolidayStatus.NotFound
                                                  ? 'No holidays'
                                                  : value.items.isNotEmpty
                                                      ? value.items[0]
                                                              .holidayTitle
                                                          as String
                                                      : 'Error',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 45,
                                              ),
                                            ),
                                    ),
                                    Text(
                                      value.holidayStatus ==
                                              HolidayStatus.Loading
                                          ? '-- / -- /--'
                                          : value.holidayStatus ==
                                                  HolidayStatus.NotFound
                                              ? '-- / -- /--'
                                              : value.items.isNotEmpty
                                                  ? value.items[0].startDate
                                                      as String
                                                  : 'Error',
                                      style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8, left: 20),
              child: Text(
                'Recent Leaves',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 1),
              child: Container(
                height: 330,
                // child: ListView.builder(
                //   itemCount: 3,
                //   itemBuilder: (_, i) => Column(
                //     children: [
                //       LeaveItem(),
                //       Divider(),
                //     ],
                //   ),
                // ),
                child: Consumer<Leaves>(
                  builder: (context, leaves, child) => leaves.leaveStatus ==
                          LeavesStatus.Loading
                      ? Center(
                          child: Container(
                              height: 50,
                              width: 50,
                              child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: CircularProgressIndicator())),
                        )
                      : leaves.leaveStatus == LeavesStatus.NotFound
                          ? Center(
                              child: Container(
                                  height: 50,
                                  width: 50,
                                  child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                          'Error Check you network Connection'))),
                            )
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: leaves.items.length <= 3
                                  ? leaves.items.length
                                  : 3,
                              itemBuilder: (ctx, i) => Column(
                                children: [
                                  LeaveItem(leaves.items[i]),
                                  i + 1 == 3
                                      ? TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MyHomePage(2)));
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.remove_red_eye,
                                                size: 20,
                                              ),
                                              Text(
                                                'More ...',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ))
                                      : Divider(),
                                ],
                              ),
                            ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5, left: 20, right: 20),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RequestLeave()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.add_box,
                            size: 20,
                          ),
                        ),
                        Text('Request new leave'),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
