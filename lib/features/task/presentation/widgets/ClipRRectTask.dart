import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClipRRectTask extends StatelessWidget {
  final String name;
  final String description;
  final Function update;
  final Function delete;
  const ClipRRectTask({
    super.key,
    required this.name,
    required this.description,
    required this.update,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: BoxBorder.all(
            width: 1,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: ExpansionTile(
          title: Text(
            name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          //trailing: SizedBox.shrink(),
          iconColor: Theme.of(context).colorScheme.secondary,
          collapsedIconColor: Theme.of(context).colorScheme.primary,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.all(10),
              child: Text(
                description,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await update();
                    },
                    child: Icon(
                      CupertinoIcons.settings,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await delete();
                    },
                    child: Icon(
                      CupertinoIcons.trash,
                      color: Theme.of(context).colorScheme.primary,
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
