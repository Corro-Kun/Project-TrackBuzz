import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackbuzz/core/database/data_base.dart';
import 'package:trackbuzz/core/setting/app_reloader.dart';
import 'package:trackbuzz/shared/functions/message.dart';
import 'package:trackbuzz/shared/functions/notification_download.dart';
import 'package:trackbuzz/shared/widgets/pre_loader.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => Settings());
  }

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool loadingDownload = false;
  bool loadingImport = false;

  _loadDownload(bool value) {
    setState(() {
      loadingDownload = value;
    });
  }

  _loadImport(bool value) {
    setState(() {
      loadingImport = value;
    });
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
            !loadingDownload
                ? GestureDetector(
                    onTap: () async {
                      _loadDownload(true);

                      final zip = await DataBase().exportToZip();

                      final timestamp = DateTime.now().millisecondsSinceEpoch;

                      String? Directory = await FilePicker.platform.saveFile(
                        bytes: zip,
                        fileName: 'trackbuzz_backup_$timestamp.zip',
                      );

                      _loadDownload(false);

                      if (Directory != null) {
                        final preferences =
                            await SharedPreferences.getInstance();
                        final bool notifications =
                            preferences.getBool('notifications') ?? false;

                        if (notifications) {
                          notificationDownload(
                            Directory!.substring(Directory.indexOf(':') + 1),
                            'download the backup',
                            loc,
                          );
                        } else {
                          message(
                            context,
                            '${loc?.translate('file_download') ?? 'downloaded file'}: ${Directory.substring(Directory.indexOf(':') + 1)}',
                            5,
                          );
                        }
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
                  )
                : const PreLoader(),
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
            !loadingImport
                ? GestureDetector(
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
                                  textStyle: Theme.of(
                                    context,
                                  ).textTheme.labelLarge,
                                ),
                                child: Text(
                                  loc?.translate('cancel') ?? 'Cancel',
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: Theme.of(
                                    context,
                                  ).textTheme.labelLarge,
                                ),
                                child: Text(
                                  loc?.translate('accept') ?? 'Accept',
                                ),
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  _loadImport(true);
                                  FilePickerResult? result = await FilePicker
                                      .platform
                                      .pickFiles(
                                        type: FileType.custom,
                                        allowedExtensions: ['zip'],
                                        allowMultiple: false,
                                      );
                                  if (result != null) {
                                    final zip = File(result.files.single.path!);
                                    await DataBase().importFromZip(zip);
                                  }
                                  _loadImport(false);
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
                  )
                : const PreLoader(),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(2),
                color: Theme.of(context).colorScheme.surface,
                child: Icon(
                  CupertinoIcons.xmark,
                  size: 30,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
