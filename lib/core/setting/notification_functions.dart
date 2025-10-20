import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';

void handleNotificationAction(NotificationResponse response) {
  final String? payload = response.payload;
  final String? actionId = response.actionId;

  if (payload == null) return;

  switch (actionId) {
    case 'open_file':
      _openFile(payload);
      break;
    case 'open_folder':
      _openFolder(payload);
      break;
    default:
      //_openFile(payload);
      break;
  }
}

Future<void> _openFile(String filePath) async {
  try {
    final file = File(filePath);

    if (await file.exists()) {
      final result = await OpenFile.open(
        filePath,
        type: 'application/x-zip-compressed',
      );

      if (result.type == ResultType.noAppToOpen) {
        _openFolder(filePath);
      }
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> _openFolder(String filePath) async {
  try {
    final file = File(filePath);
    final directory = file.parent;

    if (await directory.exists()) {
      final result = await OpenFile.open(directory.path);
      print(result);
    }
  } catch (e) {
    print('Error: $e');
  }
}
