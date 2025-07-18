import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SwitchCustom extends StatefulWidget {
  final bool light;
  final Function(bool value) onChanged;
  const SwitchCustom({super.key, required this.light, required this.onChanged});

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
      value: widget.light,
      overlayColor: overlayColor,
      trackColor: trackColor,
      thumbColor: WidgetStatePropertyAll<Color>(
        Theme.of(context).colorScheme.secondary,
      ),
      onChanged: (bool value) {
        widget.onChanged(value);
      },
    );
  }
}
