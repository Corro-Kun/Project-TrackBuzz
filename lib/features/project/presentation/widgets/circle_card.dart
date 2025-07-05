import 'dart:io';

import 'package:flutter/material.dart';

class CircleCard extends StatelessWidget {
  final VoidCallback function;
  final bool active;
  final String img;
  const CircleCard({
    super.key,
    required this.function,
    required this.active,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow:
              active
                  ? [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary,
                      blurRadius: 5,
                      spreadRadius: 0.0,
                    ),
                  ]
                  : [],
        ),
        clipBehavior: Clip.hardEdge,
        child:
            !img.contains('https:')
                ? Image.file(File(img))
                : Image.network(img),
      ),
    );
  }
}
