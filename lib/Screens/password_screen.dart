import 'package:app_conge/Screens/profile_screen.dart';
import 'package:app_conge/main.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Utility/shared_preference.dart';
import '../providers/user_provider.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final _formPass = GlobalKey<FormState>();
  String _currentPassword = '';
  String _newPassword = '';
  String _confirmPassword = '';
  var idU = '';

  final _confirm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    void submit() {
      final form = _formPass.currentState;

      if (form!.validate()) {
        form.save();
        print('$_currentPassword -- $_newPassword -- $_confirmPassword');
        final resp = user
            .updatePassword(user.user.userId as String, _currentPassword,
                _newPassword, _confirmPassword)
            .then((response) {
          if (response['status']) {
            AwesomeDialog(
                    context: context,
                    dialogType: DialogType.SUCCES,
                    animType: AnimType.BOTTOMSLIDE,
                    dismissOnTouchOutside: false,
                    title: 'Success',
                    desc: 'Password changed successfully',
                    btnOkOnPress: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => MyHomePage(1)));
                    },
                    btnOkColor: Colors.green)
                .show();
          } else {
            AwesomeDialog(
                    context: context,
                    dialogType: DialogType.ERROR,
                    animType: AnimType.BOTTOMSLIDE,
                    dismissOnTouchOutside: false,
                    title: 'Error',
                    desc:
                        'An error occurred while changing passwrd : ${response['message']}',
                    btnOkOnPress: () {
                    },
                    btnOkColor: Colors.red)
                .show();
          }
        });
      }
    }

    return Scaffold(
        body: Form(
      key: _formPass,
      child: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60)),
              color: Color(0xff2E94B5).withOpacity(0.7),
            ),
            child: Center(
                child: Container(
              margin: EdgeInsets.only(right: 20, top: 0, left: 20),
              alignment: Alignment.center,
              child: Text(
                "Change Password",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 20, right: 20, top: 30),
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
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
                icon: Icon(Icons.password_outlined),
                hintText: "Current Password",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Pleaser Enter a password';
                }
                return null;
              },
              onSaved: (value) => _currentPassword = value as String,
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xffEEEEEE),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 20),
                    blurRadius: 100,
                    color: Color(0xffEEEEEE)),
              ],
            ),
            child: TextFormField(
              cursorColor: new Color(0x21CACBF).withOpacity(0.6),
              decoration: InputDecoration(
                focusColor: new Color(0x1CACBF).withOpacity(0.6),
                icon: Icon(
                  Icons.password_sharp,
                ),
                hintText: "New Password",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              controller: _confirm,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Pleaser Enter a password !';
                }
                if (text.length < 5) {
                  return 'Password must be at least 5 cases';
                }
                return null;
              },
              onSaved: (value) => _newPassword = value as String,
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xffEEEEEE),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 20),
                    blurRadius: 100,
                    color: Color(0xffEEEEEE)),
              ],
            ),
            child: TextFormField(
              cursorColor: new Color(0x21CACBF).withOpacity(0.6),
              decoration: InputDecoration(
                focusColor: new Color(0x1CACBF).withOpacity(0.6),
                icon: Icon(
                  Icons.password_sharp,
                ),
                hintText: "Confirm new Password",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Please Confirm your password !';
                }
                if (text != _confirm.text) {
                  return 'Passwords does not match ! ';
                }
                return null;
              },
              onSaved: (value) => _confirmPassword = value as String,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 30),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    submit();
                  },
                  child: user.passwordStatus == PasswordStatus.Changing
                      ? SizedBox(
                          height: 27,
                          width: 27,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(Icons.key),
                            ),
                            Text('Change Password'),
                          ],
                        )),
            ),
          )
        ],
      )),
    ));
  }
}
