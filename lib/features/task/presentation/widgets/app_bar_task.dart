import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppBarTask extends StatelessWidget implements PreferredSizeWidget {
  final String img;
  const AppBarTask({super.key, required this.img});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Tareas',
        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
      ),
      elevation: 0.0,
      foregroundColor: Theme.of(context).colorScheme.secondary,
      actions: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: !img.contains('https:')
                  ? FileImage(File(img))
                  : NetworkImage(img),
              fit: BoxFit.cover,
            ),
          ),
        ),

        SizedBox(width: 10),
      ],
    );
  }
}
