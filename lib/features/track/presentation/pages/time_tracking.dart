import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackbuzz/shared/widgets/app_bar_main.dart';
import 'package:trackbuzz/shared/widgets/drawer_custom.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';
import 'package:workmanager/workmanager.dart';

class TimeTracking extends StatefulWidget {
  const TimeTracking({super.key});

  @override
  State<TimeTracking> createState() => _TimeTrackingState();
}

class _TimeTrackingState extends State<TimeTracking>
    with WidgetsBindingObserver {
  int _seconds = 0;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _startBackgroundTask();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  void _startCounter() {
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void _startBackgroundTask() {
    Workmanager().registerPeriodicTask(
      "counter",
      "counter",
      frequency: Duration(minutes: 15),
      initialDelay: Duration(seconds: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isRunning) {
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _seconds++;
        });
      });
    }

    final hours = (_seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((_seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');

    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBarMain(title: loc?.translate('chronometer') ?? 'Chronometer'),
      drawer: DrawerCustom(),
      body: ListView(
        children: [
          Container(
            height: 300,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Center(
                  child: Text(
                    '$hours:$minutes:$seconds',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                _startCounter();
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Center(
                  child: Icon(
                    _isRunning
                        ? CupertinoIcons.pause_fill
                        : CupertinoIcons.play_fill,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.app,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                SizedBox(width: 5),
                Text(
                  loc?.translate('project') ?? 'Project:',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 70,
            margin: EdgeInsets.only(right: 20, left: 20, top: 5, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.rectangle_paperclip,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                SizedBox(width: 5),
                Text(
                  loc?.translate('task_optional') ?? 'Task (optional):',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 70,
            margin: EdgeInsets.only(right: 20, left: 20, top: 5, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: BoxBorder.all(
                width: 1,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            child: Center(
              child: Icon(
                CupertinoIcons.add,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
