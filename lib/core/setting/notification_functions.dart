import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';

const _files = {
  'zip': 'application/x-zip-compressed',
  'csv': 'application/vnd.ms-excel',
};

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
    final type = filePath.substring(filePath.indexOf('.'));
    final file = File(filePath);

    if (await file.exists()) {
      final result = await OpenFile.open(filePath, type: _files[type]);

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
      await OpenFile.open(directory.path);
    }
  } catch (e) {
    print('Error: $e');
  }
}
