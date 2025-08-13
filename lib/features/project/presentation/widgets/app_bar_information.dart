import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackbuzz/features/task/presentation/pages/list_task.dart';

class AppBarInformation extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String img;
  final bool update;
  final int id;
  const AppBarInformation({
    super.key,
    required this.title,
    required this.update,
    required this.id,
    required this.img,
  });

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
      leading: GestureDetector(
        onTap: () => Navigator.pop(context, update),
        child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          alignment: Alignment.center,
          color: Theme.of(context).colorScheme.surface,
          child: Icon(
            CupertinoIcons.left_chevron,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      foregroundColor: Theme.of(context).colorScheme.secondary,
      actions: [
        GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ListTask(idProject: id, img: img),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            alignment: Alignment.center,
            width: 37,
            child: Icon(
              CupertinoIcons.rectangle_stack_fill,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Scaffold.of(context).openDrawer(),
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
