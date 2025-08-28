import 'package:flutter/material.dart';

void message(context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.bold,
        ),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Theme.of(context).colorScheme.primary,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
