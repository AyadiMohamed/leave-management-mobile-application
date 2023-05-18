import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatefulWidget {
  DateTime? _selectedDateStart;
  DateTime? _selectedDateEnd;
  String startDate;
  String endDate;
  DatePickerWidget(this._selectedDateEnd, this._selectedDateStart,
      this.startDate, this.endDate);

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  void _presentDatePicker(String type) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2050),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        if (type == 'Start') {
          widget._selectedDateStart = pickedDate;
          widget.startDate = DateFormat.yMMMd().format(pickedDate);
        } else {
          if (type == 'End') {
            widget._selectedDateEnd = pickedDate;
            widget.endDate = DateFormat.yMMMd().format(pickedDate);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
            _presentDatePicker('Start');
          },
          child: Container(
            height: 50,
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
                  widget.startDate,
                  style: TextStyle(fontSize: 18),
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
                  widget.endDate,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
