import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:trackbuzz/utils/constants.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

void notificationDownload(
  String path,
  description,
  AppLocalizations? loc,
) async {
  AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
        'backup_channel',
        'Backup Notifications',
        channelDescription: description,
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
        autoCancel: false,
        ongoing: true,
        actions: [
          AndroidNotificationAction(
            'open_file',
            loc?.translate('open_file') ?? 'Open File',
            showsUserInterface: true,
          ),
          AndroidNotificationAction(
            'open_folder',
            loc?.translate('open_folder') ?? 'Open Folder',
            showsUserInterface: true,
          ),
        ],
      );

  final NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidNotificationDetails,
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    loc?.translate('file_download') ?? 'downloaded file',
    path,
    platformChannelSpecifics,
    payload: path,
  );
}
