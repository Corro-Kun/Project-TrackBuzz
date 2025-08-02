import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

SendPort? uiSendPort;

@pragma('vm:entry-point')
void callbackmanger() {
  final DateTime now = DateTime.now();
  uiSendPort?.send(now.toIso8601String());
}

ThemeData appThemeDark = ThemeData(
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF0D0D0D),
    primary: Color(0xFF590253),
    secondary: Color(0xFFF2F2F2),
  ),
);
