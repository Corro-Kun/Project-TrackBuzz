import 'package:flutter/material.dart';

class Billing extends StatelessWidget {
  final String value;
  const Billing({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.only(right: 20, left: 20, top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Center(
        child: Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
