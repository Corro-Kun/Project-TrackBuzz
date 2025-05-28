import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackbuzz/shared/widgets/app_bar_main.dart';
import 'package:trackbuzz/shared/widgets/drawer_custom.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

class ProjectReport extends StatelessWidget {
  const ProjectReport({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBarMain(title: loc?.translate('reports') ?? 'Reports'),
      drawer: DrawerCustom(),
      body: ListView(
        children: [
          SizedBox(height: 10),
          Center(
            child: Icon(
              Icons.data_exploration_outlined,
              size: 80,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
