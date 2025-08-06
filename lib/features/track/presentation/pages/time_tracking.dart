import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackbuzz/features/track/presentation/widgets/clock_custom.dart';
import 'package:trackbuzz/shared/widgets/app_bar_main.dart';
import 'package:trackbuzz/shared/widgets/drawer_custom.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

class TimeTracking extends StatefulWidget {
  const TimeTracking({super.key});

  @override
  State<TimeTracking> createState() => _TimeTrackingState();
}

class _TimeTrackingState extends State<TimeTracking> {
  int _seconds = 0;
  bool _isRunning = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    //_startBackgroundService();
  }

  /*
  Future<void> _startBackgroundService() async {
    await FlutterBackgroundService().configure(
      androidConfiguration: AndroidConfiguration(
        onStart: (service) {
          _onBackgroundServiceStart();
        },
        autoStart: true,
        isForegroundMode: true,
      ),
      iosConfiguration: IosConfiguration(),
    );
  }

  @pragma('vm:entry-point')
  void _onBackgroundServiceStart() {
    final service = FlutterBackgroundService();
    int seconds = 0;
    Timer.periodic(Duration(seconds: 1), (timer) async {
      seconds++;
      if (seconds % 60 == 0) {
        _updateNotification();
      }
      service.invoke('update', {'seconds': seconds});
    });
  }

  Future<void> _updateNotification() async {
    final hours = (_seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((_seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'counter',
          'text',
          channelDescription: 'proceso',
          importance: Importance.low,
          priority: Priority.low,
          ongoing: true,
          showWhen: false,
        );

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'test',
      'tiempo: $hours:$minutes:$seconds',
      platformChannelSpecifics,
    );
  }
  */
  void _startCounter() {
    setState(() => _isRunning = true);
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() => _seconds++);
    });
  }

  void _stopCounter() {
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*
    if (_isRunning) {
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _seconds++;
        });
      });
    }
    */

    final hours = (_seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((_seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');

    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBarMain(title: loc?.translate('chronometer') ?? 'Chronometer'),
      drawer: DrawerCustom(),
      body: ListView(
        children: [
          ClockCustom(hours: hours, minutes: minutes, seconds: seconds),
          Center(
            child: GestureDetector(
              onTap: () {
                if (!_isRunning) {
                  _startCounter();
                } else {
                  _stopCounter();
                }
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
          GestureDetector(
            onTap: () {},
            child: Container(
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
