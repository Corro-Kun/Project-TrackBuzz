import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  final String img;
  const MainCard({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary,
            blurRadius: 40,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
          Center(
            child: Container(
              height: 200,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                  image: !img.contains('lib/assets/img/example')
                      ? FileImage(File(img))
                      : AssetImage(img),
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
