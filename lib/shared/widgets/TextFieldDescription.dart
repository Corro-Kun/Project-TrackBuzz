import 'package:flutter/material.dart';

class TextFieldDescription extends StatelessWidget {
  final TextEditingController controller;
  final Function? onChange;
  const TextFieldDescription({
    super.key,
    required this.controller,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 4,
      onChanged: (value) {
        if (onChange != null) {
          onChange!(value);
        }
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 1,
          ),
        ),
      ),
      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
    );
  }
}
