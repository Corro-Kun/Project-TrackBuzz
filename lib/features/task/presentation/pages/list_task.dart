import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackbuzz/core/di/injection_container.dart';
import 'package:trackbuzz/features/task/presentation/bloc/Task/task_bloc.dart';
import 'package:trackbuzz/features/task/presentation/bloc/Task/task_event.dart';
import 'package:trackbuzz/features/task/presentation/bloc/Task/task_state.dart';
import 'package:trackbuzz/features/task/presentation/pages/create_task.dart';
import 'package:trackbuzz/features/task/presentation/widgets/app_bar_task.dart';
import 'package:trackbuzz/shared/widgets/pre_loader.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

class ListTask extends StatelessWidget {
  final int idProject;
  final String img;
  const ListTask({super.key, required this.idProject, required this.img});

  static Route<void> route(int idProject, String img) {
    return MaterialPageRoute(
      builder: (context) => ListTask(idProject: idProject, img: img),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BlocProvider(
      create: (context) => sl<TaskBloc>()..add(GetTasks(id: idProject)),
      child: Scaffold(
        appBar: AppBarTask(
          img: img,
          title: loc?.translate('title_task') ?? 'Tasks',
        ),
        floatingActionButton: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoaded) {
              return FloatingActionButton(
                onPressed: () async {
                  final result = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CreateTask(id: idProject, img: img),
                    ),
                  );
                  if (result == true) {
                    context.read<TaskBloc>().add(GetTasks(id: idProject));
                  }
                },
                child: Icon(
                  CupertinoIcons.rectangle_stack_fill_badge_plus,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoading) {
              return PreLoader();
            } else if (state is TaskLoaded) {
              return ListView(
                children: List.generate(state.tasks.length, (i) {
                  return Padding(
                    padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                    child: ClipRRect(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: BoxBorder.all(
                            width: 1,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: ExpansionTile(
                          title: Text(
                            state.tasks[i].name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          //trailing: SizedBox.shrink(),
                          iconColor: Theme.of(context).colorScheme.secondary,
                          collapsedIconColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          children: [
                            Padding(
                              padding: EdgeInsetsGeometry.all(10),
                              child: Text(
                                state.tasks[i].description,
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsGeometry.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    child: Icon(
                                      CupertinoIcons.settings,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      context.read<TaskBloc>().add(
                                        DeleteTask(index: i),
                                      );
                                    },
                                    child: Icon(
                                      CupertinoIcons.trash,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
