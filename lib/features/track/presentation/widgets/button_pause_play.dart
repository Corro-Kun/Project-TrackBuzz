import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonPausePlay extends StatelessWidget {
  final bool state;
  final bool running;
  const ButtonPausePlay({
    super.key,
    required this.running,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: state
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.primary.withOpacity(0.5),
      ),
      child: Center(
        child: Icon(
          running ? CupertinoIcons.pause_fill : CupertinoIcons.play_fill,
          color: state
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.secondary.withOpacity(0.5),
        ),
      ),
    );
  }
}
