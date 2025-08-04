import 'dart:isolate';
import 'dart:ui';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:trackbuzz/shared/widgets/app_bar_main.dart';
import 'package:trackbuzz/shared/widgets/drawer_custom.dart';
import 'package:trackbuzz/utils/constants.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

@pragma('vm:entry-point')
void callback() {
  final DateTime now = DateTime.now();
  IsolateNameServer.lookupPortByName('counter')?.send(now.toIso8601String());
}

class TimeTracking extends StatefulWidget {
  const TimeTracking({super.key});

  @override
  State<TimeTracking> createState() => _TimeTrackingState();
}

class _TimeTrackingState extends State<TimeTracking> {
  int _seconds = 0;
  bool _isRunning = false;
  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    _initAlarm();
    _setupIsolate();
  }

  void _setupIsolate() {
    try {
      IsolateNameServer.registerPortWithName(_port.sendPort, 'counter');
      _port.listen((dynamic data) {
        debugPrint('test');
        _updateCounterFromBackground();
      });
    } catch (e) {
      debugPrint('error: $e');
    }
  }

  Future<void> _initAlarm() async {
    try {
      await AndroidAlarmManager.initialize();
      await AndroidAlarmManager.periodic(
        const Duration(seconds: 1),
        0,
        callback,
        exact: true,
        wakeup: true,
        rescheduleOnReboot: true,
      );
    } catch (e) {
      debugPrint('error');
    }
  }

  Future<void> _updateCounterFromBackground() async {
    if (_isRunning) {
      setState(() {
        _seconds++;
      });
      await _updateNotification();
    }
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

  void _startCounter() {
    setState(() {
      _isRunning = true;
    });
    _updateNotification();
  }

  @override
  void dispose() {
    _port.close();
    IsolateNameServer.removePortNameMapping('counter');
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
