import 'dart:io';

import 'package:flutter/material.dart';

class CardProjectChronometer extends StatelessWidget {
  final String title;
  final String img;
  final Function function;
  const CardProjectChronometer({
    super.key,
    required this.title,
    required this.img,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        height: 185,
        width: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 150,
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.primary,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary,
                    blurRadius: 10,
                    spreadRadius: 0.0,
                  ),
                ],
                image: DecorationImage(
                  image: !img.contains('https:')
                      ? FileImage(File(img))
                      : NetworkImage(img),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              title,
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
