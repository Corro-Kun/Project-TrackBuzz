import 'package:flutter/material.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

class Searcher extends StatelessWidget {
  const Searcher({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return TextField(
      decoration: InputDecoration(
        hintText: loc?.translate('search') ?? 'Search',
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
          fontSize: 14,
        ),
        contentPadding: const EdgeInsets.all(15),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 1,
          ),
        ),
      ),
    );
  }
}
