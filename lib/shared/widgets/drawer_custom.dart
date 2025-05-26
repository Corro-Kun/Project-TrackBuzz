import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.75,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Center(child: Icon(CupertinoIcons.settings, size: 60)),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Ajustes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(CupertinoIcons.book),
                  SizedBox(width: 5),
                  Text('Idioma', style: TextStyle(fontSize: 14)),
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
                  Icon(CupertinoIcons.circle_bottomthird_split),
                  SizedBox(width: 5),
                  Text('Personalizar', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Color Principal'),
                  Container(
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Color Texto'),
                  Container(
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Color Fondo'),
                  Container(
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(CupertinoIcons.folder),
                  SizedBox(width: 5),
                  Text('Importar Datos', style: TextStyle(fontSize: 14)),
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
                      style: TextStyle(fontWeight: FontWeight.bold),
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
