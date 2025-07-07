import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

class PictureProject extends StatelessWidget {
  final String img;
  const PictureProject({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 220,
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
          image:
              !img.contains('https:')
                  ? FileImage(File(img))
                  : NetworkImage(img),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
          Center(
            child: Container(
              height: 160,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                  image:
                      !img.contains('https:')
                          ? FileImage(File(img))
                          : NetworkImage(img),
                  fit: BoxFit.cover,
                ),
              ),
              clipBehavior: Clip.hardEdge,
            ),
          ),
        ],
      ),
    );
  }
}
