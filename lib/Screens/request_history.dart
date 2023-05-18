import 'package:app_conge/Models/entity/leave_entity.dart';
import 'package:flutter/material.dart';

import '../Models/leave.dart';
import 'change_request.dart';

class RequestHistory extends StatefulWidget {
  LeaveEntity leave;

  RequestHistory(this.leave);
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<RequestHistory> {
  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  initWidget() {
    return Scaffold(
        appBar: AppBar(
          //toolbarHeight: 40,
          title: Text(
            "Request History",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "DaysOne",
            ),
          ),
        ),
        body: Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 50),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  )
                ]),
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(5),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.airplanemode_active,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.all(8),
                      child: widget.leave.status == 'pending'
                          ? Text(
                              'Pending',
                              style: TextStyle(
                                  fontFamily: "Roboto-bold",
                                  fontSize: 20,
                                  color: Colors.orange),
                            )
                          : widget.leave.status == 'approved'
                              ? Text(
                                  'Approved',
                                  style: TextStyle(
                                      fontFamily: "Roboto-bold",
                                      fontSize: 20,
                                      color: Colors.green),
                                )
                              : widget.leave.status == 'adminproposition'
                                  ? Text(
                                      'Admin Proposition',
                                      style: TextStyle(
                                          fontFamily: "Roboto-bold",
                                          fontSize: 20,
                                          color: Colors.blue),
                                    )
                                  : Text(
                                      'Refused',
                                      style: TextStyle(
                                          fontFamily: "Roboto-bold",
                                          fontSize: 20,
                                          color: Colors.red),
                                    )),
                  Container(
                    margin: EdgeInsets.all(8),
                    child: Text(
                      " From ${(widget.leave.startDate)} to ${(widget.leave.endDate)} ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontFamily: "Raleway",
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 18,
                    indent: 18,
                    endIndent: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.all(15),
                            child: Text(
                              "Type :",
                              style: TextStyle(
                                color: Colors.black54,
                                fontFamily: "Raleway",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(15),
                            child: Text(
                              "Sent By :",
                              style: TextStyle(
                                color: Colors.black54,
                                fontFamily: "Raleway",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            height: 90,
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "Description :",
                              style: TextStyle(
                                color: Colors.black54,
                                fontFamily: "Raleway",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              "Attachement :",
                              style: TextStyle(
                                color: Colors.black54,
                                fontFamily: "Raleway",
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(15),
                            child: Text(
                              "${(widget.leave.type)}",
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontFamily: "Roboto-bold",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(15),
                            child: widget.leave.status == 'pending'
                                ? Text(
                                    'Me',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontFamily: "Roboto-bold",
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    widget.leave.sentBy as String,
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontFamily: "Roboto-bold",
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                          Container(
                            height: 90,
                            padding: EdgeInsets.all(15),
                            child: widget.leave.status == 'declined'
                                ? Text(
                                    "${(widget.leave.denialDesc)}",
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontFamily: "Roboto-bold",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Text(
                                    "${(widget.leave.leaveDesc)}",
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontFamily: "Roboto-bold",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              " ${(widget.leave.attachment)}",
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontFamily: "Roboto-bold",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ))
                    ],
                  ),
                  widget.leave.status == 'pending'
                      ? ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ChangeRequest(widget.leave)));
                          },
                          child: Text(
                            "Change",
                            style: TextStyle(
                              fontFamily: "Robot-bold",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            )));
  }
}
