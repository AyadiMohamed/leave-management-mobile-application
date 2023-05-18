import 'package:app_conge/Screens/main_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Models/entity/leave_entity.dart';
import '../Models/leave.dart';
import '../main.dart';
import '../providers/leaves.dart';
import 'history_screen.dart';

class ChangeRequest extends StatefulWidget {
  LeaveEntity leave;
  ChangeRequest(this.leave);

  @override
  State<ChangeRequest> createState() => _ChangeRequestState();
}

class _ChangeRequestState extends State<ChangeRequest> {
  final _form = GlobalKey<FormState>();
  final items = [
    'Sick leave',
    'Casual leave',
    'Maternity leave',
    'Religious holidays'
  ];
  late Leaves leavesData;
  DateTime? _selectedDateStart;
  DateTime? _selectedDateEnd;
  String startDate = 'Start Date';
  String endDate = 'End Date  ';
  String? value;
  String btnText = 'Select a file';
  String description = '';
  int attachments = 0;

  @override
  void initState() {
    
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
                      '$value',
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
                    'Attachments : ',
                    style: TextStyle(fontSize: 18),
                  ),
                  attachments == 1
                      ? Text(
                          'Yes',
                          style: TextStyle(fontSize: 14),
                        )
                      : Text(
                          'No',
                          style: TextStyle(fontSize: 14),
                        ),
                  Divider(),
                ],
              ),
              btnCancelOnPress: () {},
              btnCancelColor: Theme.of(context).primaryColor,
              btnOkOnPress: () {
                var leave = Leave(
                    id: DateTime.now().toString(),
                    startDate:
                        DateFormat('dd/MM/yyyy').format(_selectedDateStart!),
                    endDate: DateFormat('dd/MM/yyyy').format(_selectedDateEnd!),
                    type: value!,
                    status: "Pending",
                    leaveDesc: description,
                    attachment: attachments == 1 ? 'Yes' : 'No',
                    createdAt: DateTime.now().toString());
                //leavesData.addLeave(leave);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MyHomePage(0)));
              },
              btnOkColor: Theme.of(context).primaryColor,
              btnOkText: 'Confirm')
          .show();
    }
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            //fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      );
  void _presentDatePicker(String type) {
    var firstdate = DateTime.now();
    if (type == 'End') {
      firstdate = _selectedDateStart!;
    }
    showDatePicker(
      context: context,
      initialDate: firstdate,
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
                      Container(
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
                            hint: Text(widget.leave.type as String),
                            iconSize: 30,
                            items: items.map(buildMenuItem).toList(),
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
                            initialValue: widget.leave.leaveDesc,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                            validator: (desc) {
                              if (desc!.isEmpty) {
                                return 'Please enter a description.';
                              }
                              if (desc.length < 10) {
                                return 'Should be at least 10 characters long.';
                              }
                              return null;
                            },
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
                                attachments = 0;
                                final result =
                                    await FilePicker.platform.pickFiles();
                                if (result == null) {
                                  return;
                                }
                                attachments = 1;
                                final file = result.files.first;
                                setState(() {
                                  btnText = file.name;
                                });
                              },
                              child: Text(
                                widget.leave.attachment as String,
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
