import 'package:app_conge/Models/entity/logs_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class LogItem extends StatelessWidget {
  LogsEntity log;
  LogItem(this.log);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(log.date);
        print(log.collaboratorId);
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestHistory(leave)));
      },
      child: Card(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.only(top: 7),
          height: 73,
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                DateFormat('yyyy-MMM-dd')
                    .add_Hms()
                    .format(DateTime.parse(log.date as String)),
                style: TextStyle(fontSize: 18),
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: CircleAvatar(
                backgroundColor: log.action! > 0 ? Colors.green : Colors.red,
                child:
                    Text(log.action! > 0 ? '+${log.action}' : '-${log.action}'),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                  log.action! > 0 ? 'Monthly balance adding' : 'Leave costs'),
            ),
          ),
        ),
      ),
    );
  }
}
