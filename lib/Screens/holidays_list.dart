import 'package:app_conge/Widgets/holiday_item.dart';
import 'package:app_conge/providers/holidays_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class HolidaysList extends StatelessWidget {
  const HolidaysList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Holidays of the year'),
        ),
        body: Consumer<Holidays>(
            builder: (context, value, child) => Column(
                  children: [
                    value.holidayStatus == HolidayStatus.Loading
                        ? Center(
                            child: Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                height: 50,
                                width: 50,
                                child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: CircularProgressIndicator())),
                          )
                        : value.holidayStatus == HolidayStatus.NotFound
                            ? Center(
                                child: Container(
                                    height: 50,
                                    width: 50,
                                    child: FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                            'Error Check you network Connection'))),
                              )
                            : Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                height:
                                    MediaQuery.of(context).size.height - 236,
                                child: ListView.builder(
                                  itemCount: value.itemsForUi.length,
                                  itemBuilder: (ctx, i) => Column(
                                    children: [
                                      HolidayItem(value.itemsForUi[i]),
                                    ],
                                  ),
                                ),
                              ),
                  ],
                )));
  }
}
