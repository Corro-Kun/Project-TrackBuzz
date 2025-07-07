import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackbuzz/core/setting/theme_notifier.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

class DrawerSetting extends StatelessWidget {
  final TextEditingController _valueController = TextEditingController(
    text: '10',
  );
  final TextEditingController _currencyController = TextEditingController(
    text: 'USD',
  );

  DrawerSetting({super.key});

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
                CupertinoIcons.smiley,
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
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.money_dollar,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(width: 5),
                  Text(
                    loc?.translate('bill') ?? 'Bill',
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
                dropdownMenuEntries: [
                  DropdownMenuEntry(
                    value: '0',
                    label: loc?.translate('no') ?? 'No',
                    labelWidget: Text(
                      loc?.translate('no') ?? 'No',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  DropdownMenuEntry(
                    value: '1',
                    label: loc?.translate('yes') ?? 'Yes',
                    labelWidget: Text(
                      loc?.translate('yes') ?? 'Yes',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
                initialSelection: '0',
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
                  if (value != null) {}
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.money_dollar_circle,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(width: 5),
                  Text(
                    loc?.translate('value_per_hour') ?? 'Value per Hour',
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
              child: TextField(
                controller: _valueController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1,
                    ),
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.doc_append,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(width: 5),
                  Text(
                    loc?.translate('currency') ?? 'Currency',
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
              child: TextField(
                controller: _currencyController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1,
                    ),
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            SizedBox(height: 20),
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
                      loc?.translate('save') ?? 'Save',
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: Icon(CupertinoIcons.settings)),
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: Icon(CupertinoIcons.trash)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
