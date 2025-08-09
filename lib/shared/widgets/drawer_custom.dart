import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackbuzz/core/setting/locale_notifier.dart';
import 'package:trackbuzz/core/setting/theme_notifier.dart';
import 'package:trackbuzz/shared/widgets/adjustments_announced.dart';
import 'package:trackbuzz/shared/widgets/change_color.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final loc = AppLocalizations.of(context);
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.75,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: Icon(
                CupertinoIcons.settings,
                size: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            SizedBox(height: 10),
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
                text: loc?.translate('import_data') ?? 'Import Data',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: GestureDetector(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'SVG',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
