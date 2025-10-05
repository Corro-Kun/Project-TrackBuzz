import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

class ChangeColor extends StatelessWidget {
  final Color color;
  final Function(String color) change;
  final Function() save;
  const ChangeColor({
    super.key,
    required this.color,
    required this.change,
    required this.save,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return AlertDialog(
      title: Center(
        child: Text(
          loc?.translate('choose_color') ?? 'Choose a Color',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            ColorPicker(
              pickerColor: color,
              onColorChanged: (Color _color) {
                change(_color.toHexString());
              },
              pickerAreaHeightPercent: 0.9,
              enableAlpha: true,
              hexInputBar: false,
              displayThumbColor: false,
              portraitOnly: false,
              showLabel: false,
              pickerAreaBorderRadius: BorderRadius.circular(10),
              paletteType: PaletteType.hsvWithHue,
            ),
            GestureDetector(
              onTap: () {
                save();
                Navigator.pop(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                padding: const EdgeInsets.all(10),
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
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    loc?.translate('cancel') ?? 'Cancel',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
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
