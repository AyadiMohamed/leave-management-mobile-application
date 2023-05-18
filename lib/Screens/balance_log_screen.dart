import 'package:app_conge/Widgets/log_item.dart';
import 'package:app_conge/providers/logs_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../Utility/shared_preference.dart';

class BalanceLogScreen extends StatefulWidget {
  const BalanceLogScreen({Key? key}) : super(key: key);

  @override
  State<BalanceLogScreen> createState() => _BalanceLogScreenState();
}

class _BalanceLogScreenState extends State<BalanceLogScreen> {
  @override
  Widget build(BuildContext context) {
    UserPreferences().getUser().then((value) {
      Provider.of<Logs>(context, listen: false).getLogs(value.userId as String);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Balance Logs'),
      ),
      body: Consumer<Logs>(
        builder: (context, value, child) => Column(
          children: [
            value.logStatus == LogsStatus.Loading
                ? Center(
                    child: Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        height: 50,
                        width: 50,
                        child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: CircularProgressIndicator())),
                  )
                : value.logStatus == LogsStatus.NotFound
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
                        height: MediaQuery.of(context).size.height - 236,
                        child: ListView.builder(
                          itemCount: value.items.length,
                          itemBuilder: (ctx, i) => Column(
                            children: [
                              LogItem(value.items[i]),
                              //Text(value.items[i].action as String),
                              // i + 1 < leaves.length ? Divider() : SizedBox()
                            ],
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
