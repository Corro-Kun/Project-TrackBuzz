import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
    return AlertDialog(
      title: Center(child: Text('Elige tu Color')),
      content: SingleChildScrollView(
        child: Column(
          children: [
            ColorPicker(
              pickerColor: color,
              onColorChanged: (Color _color) {
                print(_color.toHexString());
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
                    'Guardar',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
