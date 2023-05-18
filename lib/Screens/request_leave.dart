import 'package:another_flushbar/flushbar.dart';
import 'package:app_conge/Models/entity/leave_entity.dart';
import 'package:app_conge/Models/entity/typeleave_entity.dart';
import 'package:app_conge/Screens/main_screen.dart';
import 'package:app_conge/Utility/shared_preference.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Models/leave.dart';
import '../main.dart';
import '../providers/leaves.dart';
import '../providers/user_provider.dart';
import 'history_screen.dart';

class RequestLeave extends StatefulWidget {
  const RequestLeave({Key? key}) : super(key: key);

  @override
  State<RequestLeave> createState() => _RequestLeaveState();
}

class _RequestLeaveState extends State<RequestLeave> {
  final _form = GlobalKey<FormState>();
  // final items = [
  //   'Sick leave',
  //   'Casual leave',
  //   'Maternity leave',
  //   'Religious holidays'
  // ];
  late Leaves leavesData;
  DateTime? _selectedDateStart;
  DateTime? _selectedDateEnd;
  String startDate = 'Start Date';
  String endDate = 'End Date  ';
  String? value;
  String btnText = 'Select a file';
  String description = '';
  String attachments = '';
  var currentUser;
  var leaveResult;
  var requestedDays;

  @override
  void initState() {
    currentUser = Provider.of<UserProvider>(context, listen: false);
    super.initState();
  }

  void submit() {
    if (_selectedDateStart == null || _selectedDateEnd == null) {
      AwesomeDialog(
              context: context,
              dialogType: DialogType.WARNING,
              animType: AnimType.SCALE,
              headerAnimationLoop: false,
              title: 'Warning',
              desc: 'You must pick a valid periode',
              body: Center(
                child: Column(
                  children: [
                    Text(
                      'Warning',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Container(
                      height: 30,
                    ),
                    Text(
                      'You must pick a valid time period',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              btnOkOnPress: () {},
              btnOkColor: Theme.of(context).primaryColor)
          .show();
      return;
    }

    final validate = _form.currentState!.validate();
    if (validate) {
      _form.currentState!.save();
      final dateStart = DateFormat.yMMMd().format(_selectedDateStart!);
      final dateEnd = DateFormat.yMMMd().format(_selectedDateEnd!);
      AwesomeDialog(
              context: context,
              dialogType: DialogType.NO_HEADER,
              customHeader: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: 50,
                child: Icon(
                  Icons.flight,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      '$value Leave',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(
                    height: 30,
                  ),
                  Text(
                    'From $dateStart to $dateEnd',
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(
                    height: 30,
                  ),
                  Text(
                    'Description : ',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14),
                  ),
                  Divider(
                    height: 30,
                  ),
                  Text(
                    'Requested Days',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    requestedDays.toString(),
                    style: TextStyle(fontSize: 14),
                  ),
                  Divider(
                    height: 30,
                  ),
                  Text(
                    'Attachments : ',
                    style: TextStyle(fontSize: 18),
                  ),
                  attachments == ''
                      ? Text(
                          'No',
                          style: TextStyle(fontSize: 14),
                        )
                      : Text(
                          attachments,
                          style: TextStyle(fontSize: 14),
                        ),
                  Divider(),
                ],
              ),
              btnCancelOnPress: () {},
              btnCancelColor: Theme.of(context).primaryColor,
              btnOkOnPress: () {
                var leave = LeaveEntity(
                    startDate:
                        DateFormat('yyyy-MM-dd').format(_selectedDateStart!),
                    endDate: DateFormat('yyyy-MM-dd').format(_selectedDateEnd!),
                    type: value!,
                    status: "pending",
                    leaveDesc: description,
                    denialDesc: 'denial desc',
                    daysRequested: _selectedDateEnd
                        ?.difference(_selectedDateStart!)
                        .inDays,
                    attachment: attachments == '' ? 'No' : attachments,
                    sentBy: '');

                //leavesData.addLeave(leave);
                leavesData
                    .addLeave(currentUser.user.userId, leave)
                    .then((value) {
                  leaveResult = value;
                  print(leaveResult['message']);
                  if (leaveResult['status'] == true) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.SUCCES,
                      animType: AnimType.BOTTOMSLIDE,
                      dismissOnTouchOutside: false,
                      title: 'Success',
                      desc: 'Leave request Added successfully',
                      btnOkOnPress: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => MyHomePage(0)));
                      },
                    ).show();
                  } else {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.ERROR,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Error',
                      desc:
                          'Your request has been failed ${leaveResult['message']}',
                      btnOkOnPress: () {},
                      btnOkColor: Colors.red,
                    ).show();
                  }
                });
                //  print(leaveResult['message']);

                // Navigator.of(context).pushReplacement(
                //               MaterialPageRoute(
                //                   builder: (context) => MyHomePage(false)));
              },
              btnOkColor: Theme.of(context).primaryColor,
              btnOkText: 'Confirm')
          .show();
    }
  }

  DropdownMenuItem<String> buildMenuItem(LeaveTypeEntity item) =>
      DropdownMenuItem(
        value: item.leaveTitle,
        child: Text(
          item.leaveTitle as String,
          style: TextStyle(
            //fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      );
  void _presentDatePicker(String type) {
    var firstdate = DateTime.now();
    var initialdate = DateTime.now();
    if (type == 'End') {
      if (_selectedDateEnd == null) {
        firstdate = _selectedDateStart!.add(new Duration(hours: 24));
        initialdate = _selectedDateStart!.add(new Duration(hours: 24));
      } else {
        firstdate = _selectedDateStart!.add(new Duration(hours: 24));
        initialdate = _selectedDateEnd!;
      }
    } else {
      if (_selectedDateStart != null) {
        initialdate = _selectedDateStart!;
      }
    }
    showDatePicker(
      context: context,
      initialDate: initialdate,
      firstDate: firstdate,
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        if (type == 'Start') {
          _selectedDateStart = pickedDate;
          startDate = DateFormat.yMMMd().format(pickedDate);
          //startDate = DateFormat('EEE, dd/MM/yy').format(pickedDate);
          print(startDate);
        } else {
          if (type == 'End') {
            _selectedDateEnd = pickedDate;
            endDate = DateFormat.yMMMd().format(pickedDate);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    leavesData = Provider.of<Leaves>(context);
    leavesData.getLeaveTypes();
    requestedDays = _selectedDateEnd?.difference(_selectedDateStart!).inDays;
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Leave'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          'Leave Type',
                        ),
                      ),
                      Consumer<Leaves>(
                        builder: (context, valueRenamed, child) => Container(
                          margin: EdgeInsets.all(5),
                          //width: 400,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          //margin: EdgeInsets.only(top: 5),
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xff412EB5).withOpacity(0.1),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<String>(
                              value: value,
                              isExpanded: true,
                              hint: Text('Leave Type'),
                              iconSize: 30,
                              items: valueRenamed.types
                                  .map(buildMenuItem)
                                  .toList(),
                              onChanged: (value) => setState(
                                () => this.value = value,
                              ),
                              validator: (typ) {
                                if (typ == null) {
                                  return 'Please choose a leave type .';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                focusedBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                //errorBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          _presentDatePicker('Start');
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.all(5),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xff412EB5).withOpacity(0.1),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Icon(
                                  Icons.date_range,
                                  size: 30,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.fill,
                                child: Text(
                                  startDate,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (_selectedDateStart == null) {
                            Flushbar(
                              backgroundColor: Colors.red,
                              message: 'Pick a start date first !',
                              duration: Duration(seconds: 2),
                            ).show(context);
                            return;
                          }
                          _presentDatePicker('End');
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.all(5),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xff412EB5).withOpacity(0.1),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Icon(
                                  Icons.date_range,
                                  size: 30,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.fill,
                                child: Text(
                                  endDate,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (requestedDays != null)
                    Chip(
                      backgroundColor: Color(0xff412EB5).withOpacity(0.1),
                      avatar: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(requestedDays.toString(),
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                      ),
                      label: Text(
                        'Days Requested',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.normal),
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Text(
                            'Description',
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xff412EB5).withOpacity(0.1),
                          ),
                          child: TextFormField(
                            initialValue: '',
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                            onSaved: (desc) {
                              description = desc!;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Attachments',
                          textAlign: TextAlign.left,
                        ),
                        Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 5),
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xff412EB5).withOpacity(0.1),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                attachments = '';
                                final result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['jpg', 'pdf', 'png'],
                                );
                                if (result == null) {
                                  return;
                                }
                                final file = result.files.first;
                                attachments = file.name;
                                setState(() {
                                  btnText = file.name;
                                });
                              },
                              child: Text(
                                btnText,
                                style: TextStyle(color: Colors.black54),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(5),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: TextButton(
                      onPressed: () {
                        submit();
                      },
                      child: Icon(
                        Icons.check_rounded,
                        size: 33,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
