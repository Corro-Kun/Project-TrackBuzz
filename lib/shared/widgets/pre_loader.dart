import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreLoader extends StatelessWidget {
  const PreLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
