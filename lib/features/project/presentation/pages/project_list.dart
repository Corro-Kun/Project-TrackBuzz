import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackbuzz/core/di/injection_container.dart';
import 'package:trackbuzz/features/project/presentation/bloc/ListProject/list_project_bloc.dart';
import 'package:trackbuzz/features/project/presentation/bloc/ListProject/list_project_event.dart';
import 'package:trackbuzz/features/project/presentation/bloc/ListProject/list_project_state.dart';
import 'package:trackbuzz/features/project/presentation/pages/create_project.dart';
import 'package:trackbuzz/features/project/presentation/pages/project_information.dart';
import 'package:trackbuzz/features/project/presentation/widgets/searcher.dart';
import 'package:trackbuzz/shared/widgets/app_bar_main.dart';
import 'package:trackbuzz/shared/widgets/drawer_custom.dart';
import 'package:trackbuzz/shared/widgets/pre_loader.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

class ProjectList extends StatelessWidget {
  const ProjectList({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BlocProvider(
      create: (context) => sl<ListProjectBloc>()..add(GetListProject()),
      child: Scaffold(
        appBar: AppBarMain(title: loc?.translate('projects') ?? 'Projects'),
        drawer: DrawerCustom(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
                child: Searcher(),
              ),
              Text(
                'Proyecto',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Container(
                height: 200,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.primary,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary,
                      blurRadius: 40,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                          child: Container(color: Colors.transparent),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 200,
                        width: 250,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://static.wikia.nocookie.net/rezero/images/e/ea/Rem_motivando_a_Subaru.gif/revision/latest?cb=20170809212028&path-prefix=es',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        clipBehavior: Clip.hardEdge,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: ElevatedButton(
                  onPressed:
                      () => Navigator.of(
                        context,
                      ).push(ProjectInformation.route()),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  child: Text(
                    loc?.translate('see_information') ?? 'See Information',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              BlocBuilder<ListProjectBloc, ListProjectState>(
                builder: (context, state) {
                  if (state is ListProjectLoading) {
                    return PreLoader();
                  } else if (state is ListProjectLoaded) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 40),
                      height: 65,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(state.projects.length, (i) {
                          return Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).colorScheme.primary,
                                  blurRadius: 5,
                                  spreadRadius: 0.0,
                                ),
                              ],
                            ),
                            clipBehavior: Clip.hardEdge,
                            child:
                                !state.projects[i].image.contains('https:')
                                    ? Image.file(File(state.projects[i].image))
                                    : Image.network(state.projects[i].image),
                          );
                        }),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {Navigator.of(context).push(CreateProject.route())},
          child: Icon(
            Icons.my_library_add_rounded,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
