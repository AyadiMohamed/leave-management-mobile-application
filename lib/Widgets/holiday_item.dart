import 'package:app_conge/Models/entity/holiday_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/framework.dart';

class HolidayItem extends StatelessWidget {
  HolidayEntity holiday;
  HolidayItem(this.holiday);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.only(top: 7),
        height: 73,
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              '${holiday.holidayTitle}',
              style: TextStyle(fontSize: 18),
            ),
          ),
          leading: CircleAvatar(
            child: Icon(Icons.flight),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          subtitle: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                  '${DateFormat('MMM dd').format(DateTime.parse(holiday.startDate as String))} - ${DateFormat('MMM dd').format(DateTime.parse(holiday.endDate as String))}')),
        ),
      ),
    );
  }
}
