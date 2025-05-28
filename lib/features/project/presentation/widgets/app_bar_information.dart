import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarInformation extends StatelessWidget implements PreferredSizeWidget {
  const AppBarInformation({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Proyecto",
        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
      ),
      elevation: 0.0,
      foregroundColor: Theme.of(context).colorScheme.secondary,
      actions: [
        GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            alignment: Alignment.center,
            width: 37,
            child: Icon(
              CupertinoIcons.hand_draw_fill,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
