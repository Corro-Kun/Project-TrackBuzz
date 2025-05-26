import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarMain extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBarMain({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
      ),
      elevation: 0.0,
      automaticallyImplyLeading: false,
      actions: [
        GestureDetector(
          onTap: () => Scaffold.of(context).openDrawer(),
          child: Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            alignment: Alignment.center,
            width: 37,
            child: Icon(
              CupertinoIcons.settings,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
