import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackbuzz/core/database/data_base.dart';
import 'package:trackbuzz/core/setting/locale_notifier.dart';
import 'package:trackbuzz/core/setting/theme_notifier.dart';
import 'package:trackbuzz/shared/functions/message.dart';
import 'package:trackbuzz/shared/widgets/adjustments_announced.dart';
import 'package:trackbuzz/shared/widgets/change_color.dart';
import 'package:trackbuzz/shared/widgets/switch_custom.dart';
import 'package:trackbuzz/utils/constants.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

class DrawerCustom extends StatefulWidget {
  const DrawerCustom({super.key});

  @override
  State<DrawerCustom> createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  bool notifications = false;

  Future<void> getNotifications() async {
    final status = await Permission.notification.status;
    final prefs = await SharedPreferences.getInstance();
    final bool data = await prefs.getBool('notifications') ?? status.isGranted;
    setState(() {
      notifications = data;
    });
  }

  Future<void> setNotifications(value) async {
    setState(() {
      notifications = value;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications', value);
  }

  @override
  void initState() {
    super.initState();
    getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final loc = AppLocalizations.of(context);
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.75,
      child: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Icon(
                CupertinoIcons.settings,
                size: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                loc?.translate('settings') ?? 'Settings',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: AdjustmentsAnnounced(
                icon: CupertinoIcons.book,
                text: loc?.translate('language') ?? 'Language',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: DropdownMenu<String>(
                dropdownMenuEntries: [
                  DropdownMenuEntry(
                    value: 'es',
                    label: 'Español',
                    labelWidget: Text(
                      'Español',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  DropdownMenuEntry(
                    value: 'en',
                    label: 'English',
                    labelWidget: Text(
                      'English',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
                initialSelection: loc?.locale.languageCode,
                width: MediaQuery.of(context).size.width * 0.65,
                textStyle: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                trailingIcon: Icon(
                  Icons.arrow_downward_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                inputDecorationTheme: InputDecorationTheme(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1,
                    ),
                  ),
                ),
                onSelected: (String? value) {
                  if (value != null) {
                    Provider.of<LocaleNotifier>(
                      context,
                      listen: false,
                    ).setLocale(Locale(value));
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.bell,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        loc?.translate('notifications') ?? 'Notifications',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SwitchCustom(
                    light: notifications,
                    onChanged: (value) async {
                      var status = await Permission.notification.status;
                      if (value == true && !status.isGranted) {
                        final result = await Permission.notification.request();
                        if (result.isGranted) {
                          setNotifications(value);
                        }
                      } else {
                        setNotifications(value);
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: AdjustmentsAnnounced(
                icon: CupertinoIcons.circle_bottomthird_split,
                text: loc?.translate('personalize') ?? 'Personalize',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    loc?.translate('main_color') ?? 'Main Color',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            final theme = Provider.of<ThemeNotifier>(context);
                            return ChangeColor(
                              color: Theme.of(context).colorScheme.primary,
                              change: (String color) async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setString('primary', color);
                              },
                              save: () async {
                                await theme.initialize();
                              },
                            );
                          },
                        );
                      },
                    ),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                        border: BoxBorder.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    loc?.translate('text_color') ?? 'Text Color',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            final theme = Provider.of<ThemeNotifier>(context);
                            return ChangeColor(
                              color: Theme.of(context).colorScheme.secondary,
                              change: (String color) async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setString('secondary', color);
                              },
                              save: () async {
                                await theme.initialize();
                              },
                            );
                          },
                        );
                      },
                    ),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        shape: BoxShape.circle,
                        border: BoxBorder.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    loc?.translate('background_color') ?? 'Background Color',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            final theme = Provider.of<ThemeNotifier>(context);
                            return ChangeColor(
                              color: Theme.of(context).colorScheme.surface,
                              change: (String color) async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setString('surface', color);
                              },
                              save: () async {
                                await theme.initialize();
                              },
                            );
                          },
                        );
                      },
                    ),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        shape: BoxShape.circle,
                        border: BoxBorder.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
              child: GestureDetector(
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();

                  await prefs.setString('surface', 'FF0D0D0D');
                  await prefs.setString('primary', 'FF590253');
                  await prefs.setString('secondary', 'FFF2F2F2');

                  theme.initialize();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      loc?.translate('reset_color') ?? 'Reset Color',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: AdjustmentsAnnounced(
                icon: CupertinoIcons.folder,
                text: loc?.translate('data') ?? 'Data',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: GestureDetector(
                onTap: () async {
                  String? selectedDirectory = await FilePicker.platform
                      .getDirectoryPath();

                  if (selectedDirectory != null) {
                    final zip = await DataBase().exportToZip(selectedDirectory);

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
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: GestureDetector(
                onTap: () async {
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['zip'],
                        allowMultiple: false,
                      );
                },
                child: Container(
                  height: 50,
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
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
