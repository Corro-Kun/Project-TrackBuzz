import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackbuzz/core/database/data_base.dart';
import 'package:trackbuzz/core/setting/app_reloader.dart';
import 'package:trackbuzz/shared/functions/message.dart';
import 'package:trackbuzz/utils/constants.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => Settings());
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.folder,
              size: 60,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 10),
            Text(
              loc?.translate('data') ?? 'Data',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            Text(
              loc?.translate('download_description') ??
                  'Download a copy of your data.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                String? selectedDirectory = await FilePicker.platform
                    .getDirectoryPath();

                if (selectedDirectory != null) {
                  final zip = await DataBase().exportToZip(selectedDirectory);

                  final preferences = await SharedPreferences.getInstance();
                  final bool notifications =
                      preferences.getBool('notifications') ?? false;

                  if (notifications) {
                    AndroidNotificationDetails androidNotificationDetails =
                        AndroidNotificationDetails(
                          'backup_channel',
                          'Backup Notifications',
                          channelDescription: 'download the backup',
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

                    final NotificationDetails platformChannelSpecifics =
                        NotificationDetails(
                          android: androidNotificationDetails,
                        );

                    await flutterLocalNotificationsPlugin.show(
                      0,
                      loc?.translate('file_download') ?? 'downloaded file',
                      zip.path,
                      platformChannelSpecifics,
                      payload: zip.path,
                    );
                  } else {
                    message(
                      context,
                      '${loc?.translate('file_download') ?? 'downloaded file'}: ${zip.path}',
                      5,
                    );
                  }
                } else {
                  message(
                    context,
                    loc?.translate('error_save') ??
                        'Error: a folder was not selected',
                    5,
                  );
                }
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    loc?.translate('download') ?? 'Download',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              loc?.translate('import_description') ??
                  'Import the copy of your data.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        loc?.translate('delete_title') ?? 'are you sure?',
                      ),
                      content: Text(loc?.translate('delete_data') ?? ''),
                      actions: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: Text(loc?.translate('cancel') ?? 'Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: Text(loc?.translate('accept') ?? 'Accept'),
                          onPressed: () async {
                            Navigator.of(context).pop();
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['zip'],
                                  allowMultiple: false,
                                );
                            final zip = File(result!.files.single.path!);
                            await DataBase().importFromZip(zip);
                            AppReloader().reloadApp();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    loc?.translate('import') ?? 'Import',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                CupertinoIcons.xmark,
                size: 30,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
