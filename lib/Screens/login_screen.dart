import 'package:app_conge/Utility/shared_preference.dart';
import 'package:app_conge/providers/leaves.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/user_local.dart';
import '../Widgets/custom_elevated_button.dart';
import '../main.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/Login';
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _userName = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
   UserPreferences().getStatus().then((value) => print(value));
    final auth = Provider.of<AuthProvider>(context);

    void submitLogin(BuildContext context) {
      final form = _formKey.currentState;

      if (form!.validate()) {
        form.save();
        print('$_userName $_password');
        final respose = auth.login(_userName, _password).then((response) {
          if (response['status']) {
            User user = response['user'];
            print('Successful ${user.firstname}');
            print('User token :  ${user.token}');
            
            Provider.of<UserProvider>(context, listen: false).setUser(user);

            // final currentUser = Provider.of<UserProvider>(context, listen: false);
            // final leavesData = Provider.of<Leaves>(context, listen: false);
            // leavesData.getPosts(currentUser.user.userId as String);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MyHomePage(0)));
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(response['message'])));
          }
        });
      }
    }

    final loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 27,
          width: 27,
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(" Login ... Please wait"),
        )
      ],
    );

    return Scaffold(
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(60),
                          bottomRight: Radius.circular(60)),
                      color: new Color(0xDEDBED).withOpacity(0.46),
                      gradient: LinearGradient(
                        colors: [
                          new Color(0x2723F9).withOpacity(0.99),
                          new Color(0x1CACBF).withOpacity(0.99),
                          new Color(0x0EEB3E).withOpacity(0.99)
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 45),
                          child: Image.asset(
                            "assets/images/teamdev-logo.png",
                            height: 170,
                            width: 170,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20, top: 1, left: 20),
                          alignment: Alignment.center,
                          child: Text(
                            "Welcome",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 70),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE)),
                      ],
                    ),
                    child: TextFormField(
                      cursorColor: new Color(0x1CACBF),
                      decoration: InputDecoration(
                        focusColor: new Color(0x1CACBF).withOpacity(0.6),
                        icon: Icon(
                          Icons.person,
                        ),
                        hintText: "Enter Email",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Pleaser Enter Email !';
                        }
                        return null;
                      },
                      onSaved: (value) => _userName = value as String,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xffEEEEEE),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 20),
                            blurRadius: 100,
                            color: Color(0xffEEEEEE)),
                      ],
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      cursorColor: new Color(0x21CACBF).withOpacity(0.5),
                      decoration: InputDecoration(
                        focusColor: new Color(0x1CACBF).withOpacity(0.5),
                        icon: Icon(
                          Icons.vpn_key,
                        ),
                        hintText: "Enter Password",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please Enter Password !';
                        }
                        if (text.length < 5) {
                          return 'Password should be longer than 5 caracters';
                        }
                        return null;
                      },
                      onSaved: (value) => _password = value as String,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 70),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: CustomElevatedButton(
                      width: double.infinity,
                      onPressed: () async {
                        submitLogin(context);
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: auth.loggedInStatus == Status.Authenticating
                          ? loading
                          : Text('SIGN IN'),
                    ),
                  ),
                ],
              ),
            )));
  }
}
