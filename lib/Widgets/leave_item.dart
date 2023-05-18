import 'package:app_conge/Models/entity/leave_entity.dart';
import 'package:app_conge/Screens/request_history.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class LeaveItem extends StatelessWidget {
  LeaveEntity leave;
  LeaveItem(this.leave);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => RequestHistory(leave)));
      },
      child: Card(
        elevation: 3,
        child: Container(
          padding: EdgeInsets.only(top: 7),
          height: 80,
          child: ListTile(
            title: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                '${leave.startDate} - ${leave.endDate}',
                style: TextStyle(fontSize: 16),
              ),
            ),
            subtitle: Text(
              leave.type as String,
              style: TextStyle(fontSize: 14),
            ),
            leading: Icon(
              Icons.date_range,
              size: 60,
              color: Theme.of(context).primaryColor.withOpacity(0.6),
            ),
            trailing: Container(
              width: 65,
              child: leave.status == 'pending'
                  ? FittedBox(
                      fit: BoxFit.none,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.orange,
                        ),
                        child: Text(
                          'Pending',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    )
                  : leave.status == 'approved'
                      ? FittedBox(
                          fit: BoxFit.none,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.green,
                            ),
                            child: Text(
                              'Approved',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        )
                      : leave.status == 'adminproposition'
                          ? FittedBox(
                              fit: BoxFit.none,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.blue,
                                ),
                                child: Text(
                                  'ADMIN CP',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            )
                          : FittedBox(
                              fit: BoxFit.none,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.red,
                                ),
                                child: Text(
                                  'Refused',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ),
            ),
          ),
        ),
      ),
    );
  }
}
