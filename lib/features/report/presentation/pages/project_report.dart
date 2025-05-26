import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackbuzz/shared/widgets/app_bar_main.dart';
import 'package:trackbuzz/shared/widgets/drawer_custom.dart';

class ProjectReport extends StatelessWidget {
  const ProjectReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(title: 'Reportes'),
      drawer: DrawerCustom(),
      body: ListView(
        children: [
          SizedBox(height: 10),
          Center(child: Icon(Icons.data_exploration_outlined, size: 80)),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
