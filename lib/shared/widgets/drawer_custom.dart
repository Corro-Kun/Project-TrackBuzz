import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackbuzz/core/setting/theme_notifier.dart';
import 'package:trackbuzz/shared/widgets/change_color.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
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
                'Ajustes',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.book,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Idioma',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: DropdownMenu<String>(
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: 'Español', label: 'Español'),
                  DropdownMenuEntry(value: 'Ingles', label: 'Ingles'),
                ],
                initialSelection: 'Español',
                width: MediaQuery.of(context).size.width * 0.65,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.circle_bottomthird_split,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Personalizar',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 14,
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
                    'Color Principal',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  GestureDetector(
                    onTap:
                        () => showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                final theme = Provider.of<ThemeNotifier>(
                                  context,
                                );
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
                    'Color Texto',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  GestureDetector(
                    onTap:
                        () => showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                final theme = Provider.of<ThemeNotifier>(
                                  context,
                                );
                                return ChangeColor(
                                  color: Theme.of(context).colorScheme.primary,
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
                    'Color Fondo',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  GestureDetector(
                    onTap:
                        () => showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                final theme = Provider.of<ThemeNotifier>(
                                  context,
                                );
                                return ChangeColor(
                                  color: Theme.of(context).colorScheme.primary,
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
                      'Restablecer Color',
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
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.folder,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Importar Datos',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
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
