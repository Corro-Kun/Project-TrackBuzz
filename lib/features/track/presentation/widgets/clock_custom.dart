import 'package:flutter/material.dart';

class ClockCustom extends StatelessWidget {
  final String hours;
  final String minutes;
  final String seconds;

  const ClockCustom({
    super.key,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Center(
            child: Text(
              '$hours:$minutes:$seconds',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
