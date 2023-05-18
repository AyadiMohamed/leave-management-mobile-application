import 'package:app_conge/Screens/password_screen.dart';
import 'package:app_conge/providers/user_provider.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Utility/shared_preference.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserPreferences().getUser().then((value) {
         Provider.of<UserProvider>(context, listen: false).getUser(value.userId as String, value.token as String);
    } );
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<UserProvider>(
          builder: (context, value, child) => Column(
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
                  children: [
                    Padding(
                      padding: EdgeInsets.all(35),
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://cdn.pixabay.com/photo/2017/02/23/13/05/avatar-2092113_960_720.png'),
                            radius: 55,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 22),
                            child: Text(
                              //'Ahmed Ammar',
                              '${value.user.firstname} ${value.user.lastname}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              'Mobile Developer',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff412EB5).withOpacity(0.1),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.person,
                          size: 30,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 50.0),
                          child: Text(
                            //'Ahmed Ammar',
                            '${value.user.firstname} ${value.user.lastname}',
                            style: TextStyle(fontSize: 20, wordSpacing: 3),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff412EB5).withOpacity(0.1),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.date_range,
                          size: 30,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 50.0),
                          child: Text(
                            //'30, Oct, 1996',
                            '${DateFormat('dd MMMM, yy').format(DateTime.parse(value.user.birthday as String))}',
                            style: TextStyle(fontSize: 20, wordSpacing: 3),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff412EB5).withOpacity(0.1),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.phone,
                          size: 30,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 50.0),
                          child: Text(
                            //'+21699259889',
                            '+216${value.user.phoneNumber}',
                            style: TextStyle(fontSize: 20, wordSpacing: 3),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff412EB5).withOpacity(0.1),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.email,
                          size: 30,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 50),
                          // padding: EdgeInsets.all(10),
                          child: Text(
                            //'ahmed-ammar@outlook.com',
                            '${value.user.email}',
                            style: TextStyle(fontSize: 20, wordSpacing: 3),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 35,
                      margin: EdgeInsets.only(top: 50),
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff2E94B5).withOpacity(0.6),
                      ),
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PasswordScreen()));
                          },
                          child: Text(
                            'Change Password',
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
