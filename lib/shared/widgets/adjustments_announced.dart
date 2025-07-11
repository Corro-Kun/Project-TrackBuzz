import 'package:flutter/material.dart';

class AdjustmentsAnnounced extends StatelessWidget {
  final IconData icon;
  final String text;
  const AdjustmentsAnnounced({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.secondary),
        SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
