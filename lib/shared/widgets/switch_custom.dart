import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SwitchCustom extends StatefulWidget {
  const SwitchCustom({super.key});

  @override
  State<SwitchCustom> createState() => _SwitchCustomState();
}

class _SwitchCustomState extends State<SwitchCustom> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    WidgetStateProperty<Color?> trackColor =
        WidgetStateProperty<Color?>.fromMap(<WidgetStatesConstraint, Color>{
          WidgetState.selected: Theme.of(context).colorScheme.primary,
        });

    final WidgetStateProperty<Color?> overlayColor =
        WidgetStateProperty<Color?>.fromMap(<WidgetState, Color>{
          WidgetState.selected: Theme.of(
            context,
          ).colorScheme.primary.withOpacity(0.54),
          WidgetState.disabled: Theme.of(context).colorScheme.secondary,
        });
    return Switch(
      value: light,
      overlayColor: overlayColor,
      trackColor: trackColor,
      thumbColor: WidgetStatePropertyAll<Color>(
        Theme.of(context).colorScheme.secondary,
      ),
      onChanged: (bool value) {
        setState(() {
          light = value;
        });
      },
    );
  }
}
