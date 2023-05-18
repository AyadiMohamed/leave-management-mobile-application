import 'package:another_flushbar/flushbar.dart';
import 'package:app_conge/Widgets/date_picker.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Utility/shared_preference.dart';
import '../Widgets/leave_item.dart';
import '../providers/leaves.dart';
import '../providers/user_provider.dart';

enum FilterOption {
  Time,
  Approved,
  Refused,
  InProgress,
  All,
}

class HistoryScreen extends StatefulWidget {
  static const routeName = '/History';
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  var _showFilter = FilterOption.All;
  DateTime? _filterDateStart;
  DateTime? _filterDateEnd;
  String startDate = 'Start ';
  String endDate = ' End  ';
  String sortValue = 'This Month';
  final items = ['This Month', 'Last Month', 'This Year', 'Last Year'];
  late String userID;

  @override
  void initState() {
    UserPreferences().getUser().then((value) {
      userID = value.userId as String;
      Provider.of<Leaves>(context, listen: false).getLeavesByDate(
          userID as String,
          DateFormat('yyyy-MM-01').format(DateTime.now()),
          DateFormat('yyyy-MM-31').format(DateTime.now()));
    });

    super.initState();
  }

  void showDate() {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.NO_HEADER,
        customHeader: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          radius: 50,
          child: Icon(
            Icons.date_range,
            size: 60,
            color: Colors.white,
          ),
        ),
        body: StatefulBuilder(builder: (context, setState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Custom Date',
                style: TextStyle(fontSize: 18),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  //setState(()=> this.startDate = 'hhh');
                  //_presentDatePicker('Start');
                  showDatePicker(
                    context: context,
                    initialDate: _filterDateStart == null
                        ? DateTime.now()
                        : _filterDateStart!,
                    firstDate: DateTime(2019),
                    lastDate: DateTime(2050),
                  ).then((pickedDate) {
                    if (pickedDate == null) {
                      return;
                    }
                    setState(() {
                      _filterDateStart = pickedDate;
                      startDate = DateFormat.yMMMd().format(pickedDate);
                      print('$_filterDateStart ');
                    });
                  });
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 150,
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xff412EB5).withOpacity(0.1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.date_range,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(),
                      Text(
                        startDate,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (_filterDateStart == null) {
                    Flushbar(
                      backgroundColor: Colors.red,
                      message: 'Pick a start date first !',
                      duration: Duration(seconds: 2),
                    ).show(context);
                    return;
                  }
                  showDatePicker(
                    context: context,
                    initialDate: _filterDateEnd == null
                        ? _filterDateStart!
                        : _filterDateEnd!,
                    firstDate: _filterDateStart!,
                    lastDate: DateTime(2050),
                  ).then((pickedDate) {
                    if (pickedDate == null) {
                      return;
                    }
                    setState(() {
                      _filterDateEnd = pickedDate;
                      endDate = DateFormat.yMMMd().format(pickedDate);
                      print('$_filterDateEnd');
                    });
                  });
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 150,
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xff412EB5).withOpacity(0.1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.date_range,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        endDate,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
        btnCancelOnPress: () {
          setState(() {
            _filterDateStart = null;
            _filterDateEnd = null;
            startDate = 'Start ';
            endDate = ' End  ';
          });
        },
        btnCancelColor: Theme.of(context).primaryColor,
        btnOkOnPress: () {
          if (_filterDateStart == null || _filterDateEnd == null) {
            Flushbar(
              backgroundColor: Colors.red,
              message: 'Pick a valid time period !',
              duration: Duration(seconds: 2),
            ).show(context);
          } else {
            final leavesObj = Provider.of<Leaves>(context, listen: false);
            leavesObj.getLeavesByDate(
                userID as String,
                DateFormat('yyyy-MM-dd').format(_filterDateStart as DateTime),
                DateFormat('yyyy-MM-dd').format(_filterDateEnd as DateTime));
          }
        }).show();
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item as String,
          style: TextStyle(
            //fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    var leavesData = Provider.of<Leaves>(context);
    var leaves = leavesData.items;
    switch (_showFilter) {
      case FilterOption.Approved:
        leaves = leavesData.approvedItems;
        //leaves = leavesData.getLeavesByStatus(userID, 'approved');
        break;
      case FilterOption.Refused:
        leaves = leavesData.refusedItems;
        break;
      case FilterOption.InProgress:
        leaves = leavesData.pendingItems;
        break;
      default:
        leaves = leavesData.items;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaves History'),
        automaticallyImplyLeading: false, // désactiver le fléche (back)
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(
              Icons.filter_alt,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                onTap: () => setState(() {
                  _showFilter = FilterOption.InProgress;
                }),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Only In Progress'),
                    Icon(
                      Icons.pending,
                      color: Colors.grey,
                    ),
                  ],
                ),
                value: FilterOption.InProgress,
              ),
              PopupMenuItem(
                onTap: () => setState(() {
                  _showFilter = FilterOption.Approved;
                }),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Only Approved'),
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                  ],
                ),
                value: FilterOption.Approved,
              ),
              PopupMenuItem(
                onTap: () => setState(() {
                  _showFilter = FilterOption.Refused;
                }),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Only Refused'),
                    Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),
                  ],
                ),
                value: FilterOption.Refused,
              ),
              PopupMenuItem(
                onTap: () => setState(() {
                  _showFilter = FilterOption.All;
                }),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Show All'),
                    Icon(
                      Icons.format_align_justify,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
                value: FilterOption.All,
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 10, left: 10),
                    //width: 400,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    //margin: EdgeInsets.only(top: 5),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xff412EB5).withOpacity(0.1),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                        value: sortValue,
                        isExpanded: true,
                        hint: Text('Sort date'),
                        iconSize: 20,
                        items: items.map(buildMenuItem).toList(),
                        onChanged: (value) => setState(() {
                          switch (value) {
                            case 'This Month':
                              leavesData.getLeavesByDate(
                                  userID as String,
                                  DateFormat('yyyy-MM-01')
                                      .format(DateTime.now()),
                                  DateFormat('yyyy-MM-31')
                                      .format(DateTime.now()));
                              this.sortValue = value as String;
                              break;
                            case 'Last Month':
                              leavesData.getLeavesByDate(
                                  userID as String,
                                  DateFormat('yyyy-MM-01').format(DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month - 1,
                                      DateTime.now().day)),
                                  DateFormat('yyyy-MM-31').format(DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month - 1,
                                      DateTime.now().day)));
                              this.sortValue = value as String;
                              break;
                            case 'This Year':
                              leavesData.getLeavesByDate(
                                  userID as String,
                                  DateFormat('yyyy-01-01').format(DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month,
                                      DateTime.now().day)),
                                  DateFormat('yyyy-12-31').format(DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month - 1,
                                      DateTime.now().day)));
                              this.sortValue = value as String;
                              break;
                            case 'Last Year':
                              leavesData.getLeavesByDate(
                                  userID as String,
                                  DateFormat('yyyy-01-01').format(DateTime(
                                      DateTime.now().year - 1,
                                      DateTime.now().month - 1,
                                      DateTime.now().day)),
                                  DateFormat('yyyy-12-31').format(DateTime(
                                      DateTime.now().year - 1,
                                      DateTime.now().month - 1,
                                      DateTime.now().day)));
                              this.sortValue = value as String;
                              break;
                            default:
                              leavesData.getLeavesByDate(
                                  userID as String,
                                  DateFormat('yyyy-MM-01')
                                      .format(DateTime.now()),
                                  DateFormat('yyyy-MM-31')
                                      .format(DateTime.now()));
                              this.sortValue = value as String;
                          }
                        }),
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
                InkWell(
                  onTap: () {
                    Future.delayed(
                        const Duration(seconds: 0), () => showDate());
                  },
                  child: Container(
                    height: 56,
                    margin: EdgeInsets.only(top: 10, left: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xff412EB5).withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.date_range,
                            size: 25,
                          ),
                        ),
                        SizedBox(),
                        Text(
                          'Pick a date',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 56,
                  margin: EdgeInsets.only(top: 10, left: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xff412EB5).withOpacity(0.1),
                  ),
                  child: InkWell(
                    onTap: () {
                      final leavesObj =
                          Provider.of<Leaves>(context, listen: false);
                      leavesObj.getLeaves(userID);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.filter_alt,
                            size: 25,
                          ),
                        ),
                        SizedBox(),
                        Text(
                          'All',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          leavesData.leaveStatus == LeavesStatus.Loading
              ? Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 200, bottom: 10),
                      height: 50,
                      width: 50,
                      child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: CircularProgressIndicator())),
                )
              : leavesData.leaveStatus == LeavesStatus.NotFound
                  ? Center(
                      child: Container(
                          height: 50,
                          width: 50,
                          child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child:
                                  Text('Error Check you network Connection'))),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      height: MediaQuery.of(context).size.height - 236,
                      child: ListView.builder(
                        itemCount: leaves.length,
                        itemBuilder: (ctx, i) => Column(
                          children: [
                            LeaveItem(leaves[i]),
                            i + 1 < leaves.length ? Divider() : SizedBox()
                          ],
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}
