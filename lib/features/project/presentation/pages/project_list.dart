import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackbuzz/core/di/injection_container.dart';
import 'package:trackbuzz/features/project/presentation/bloc/ListProject/list_project_bloc.dart';
import 'package:trackbuzz/features/project/presentation/bloc/ListProject/list_project_event.dart';
import 'package:trackbuzz/features/project/presentation/bloc/ListProject/list_project_state.dart';
import 'package:trackbuzz/features/project/presentation/pages/create_project.dart';
import 'package:trackbuzz/features/project/presentation/pages/project_information.dart';
import 'package:trackbuzz/features/project/presentation/widgets/circle_card.dart';
import 'package:trackbuzz/features/project/presentation/widgets/main_card.dart';
import 'package:trackbuzz/features/project/presentation/widgets/searcher.dart';
import 'package:trackbuzz/shared/functions/time_format_record.dart';
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
          child: ListView(
            children: [
              const SizedBox(height: 15),
              Container(
                margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
                child: BlocBuilder<ListProjectBloc, ListProjectState>(
                  builder: (context, state) {
                    return Searcher(
                      onChange: (value) {
                        if (value.toString().isNotEmpty) {
                          context.read<ListProjectBloc>().add(
                            FilterProjects(filter: value),
                          );
                        } else {
                          context.read<ListProjectBloc>().add(GetListProject());
                        }
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 40),
              BlocBuilder<ListProjectBloc, ListProjectState>(
                builder: (context, state) {
                  if (state is ListProjectLoading) {
                    return const PreLoader();
                  } else if (state is ListProjectLoaded) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Center(
                            child: Text(
                              state.projects.isNotEmpty
                                  ? state.projects[state.index].title
                                  : loc?.translate('there_are_no_projects') ??
                                        'There are no projects',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Center(
                            child: Text(
                              state.projects.isNotEmpty
                                  ? timeFormatRecord(
                                      state.projects[state.index].second,
                                    )
                                  : '',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              const SizedBox(height: 50),
              BlocBuilder<ListProjectBloc, ListProjectState>(
                builder: (context, state) {
                  if (state is ListProjectLoading) {
                    return const PreLoader();
                  } else if (state is ListProjectLoaded) {
                    return state.projects.isNotEmpty
                        ? Center(
                            child: MainCard(
                              img: state.projects[state.index].image,
                            ),
                          )
                        : const SizedBox(height: 200);
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              const SizedBox(height: 50),
              BlocBuilder<ListProjectBloc, ListProjectState>(
                builder: (context, state) {
                  if (state is ListProjectLoading) {
                    return const PreLoader();
                  } else if (state is ListProjectLoaded) {
                    return state.projects.isNotEmpty
                        ? Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                final result = await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ProjectInformation(
                                      id: state.projects[state.index].id,
                                    ),
                                  ),
                                );
                                if (result == true) {
                                  context.read<ListProjectBloc>().add(
                                    GetListProject(),
                                  );
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              child: Text(
                                loc?.translate('see_information') ??
                                    'See Information',
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              const SizedBox(height: 30),
              BlocBuilder<ListProjectBloc, ListProjectState>(
                builder: (context, state) {
                  if (state is ListProjectLoading) {
                    return const PreLoader();
                  } else if (state is ListProjectLoaded) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 40),
                      height: 65,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.projects.length,
                        itemBuilder: (context, i) {
                          return CircleCard(
                            function: () => {
                              context.read<ListProjectBloc>().add(
                                SelectProject(index: i),
                              ),
                            },
                            active: state.index == i ? true : false,
                            img: state.projects[i].image,
                          );
                        },
                        cacheExtent: 1000,
                        addAutomaticKeepAlives: true,
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
        floatingActionButton: BlocBuilder<ListProjectBloc, ListProjectState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CreateProject()),
                );
                if (result == true) {
                  context.read<ListProjectBloc>().add(GetListProject());
                }
              },
              child: Icon(
                Icons.my_library_add_rounded,
                color: Theme.of(context).colorScheme.secondary,
              ),
            );
          },
        ),
      ),
    );
  }
}
