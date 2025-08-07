import 'package:flutter/material.dart';

class TitleChronometer extends StatelessWidget {
  final IconData icon;
  final String title;
  const TitleChronometer({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.secondary),
          SizedBox(width: 5),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
