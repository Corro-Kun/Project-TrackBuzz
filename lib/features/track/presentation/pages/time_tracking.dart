import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:trackbuzz/core/di/injection_container.dart';
import 'package:trackbuzz/features/track/presentation/bloc/Project/project_chronometer_bloc.dart';
import 'package:trackbuzz/features/track/presentation/bloc/Project/project_chronometer_event.dart';
import 'package:trackbuzz/features/track/presentation/bloc/Project/project_chronometer_state.dart';
import 'package:trackbuzz/features/track/presentation/bloc/chronometer/chronometer_bloc.dart';
import 'package:trackbuzz/features/track/presentation/bloc/chronometer/chronometer_event.dart';
import 'package:trackbuzz/features/track/presentation/bloc/chronometer/chronometer_state.dart';
import 'package:trackbuzz/features/track/presentation/widgets/button_pause_play.dart';
import 'package:trackbuzz/features/track/presentation/widgets/card_project_chronometer.dart';
import 'package:trackbuzz/features/track/presentation/widgets/clock_custom.dart';
import 'package:trackbuzz/features/track/presentation/widgets/title_chronometer.dart';
import 'package:trackbuzz/shared/widgets/app_bar_main.dart';
import 'package:trackbuzz/shared/widgets/drawer_custom.dart';
import 'package:trackbuzz/shared/widgets/pre_loader.dart';
import 'package:trackbuzz/utils/constants.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

class TimeTracking extends StatefulWidget {
  const TimeTracking({super.key});

  @override
  State<TimeTracking> createState() => _TimeTrackingState();
}

class _TimeTrackingState extends State<TimeTracking> {
  int _seconds = 0;
  bool _isRunning = false;
  Timer? _timer;
  late ChronometerBloc _chronometerBloc;
  bool _hasCalculated = false;

  @override
  void initState() {
    super.initState();
    _chronometerBloc = sl<ChronometerBloc>();
    //_startBackgroundService();
  }

  /*
  Future<void> _startBackgroundService() async {
    await FlutterBackgroundService().configure(
      androidConfiguration: AndroidConfiguration(
        onStart: (service) {
          _onBackgroundServiceStart();
        },
        autoStart: true,
        isForegroundMode: true,
      ),
      iosConfiguration: IosConfiguration(),
    );
  }

  @pragma('vm:entry-point')
  void _onBackgroundServiceStart() {
    final service = FlutterBackgroundService();
    int seconds = 0;
    Timer.periodic(Duration(seconds: 1), (timer) async {
      seconds++;
      if (seconds % 60 == 0) {
        _updateNotification();
      }
      service.invoke('update', {'seconds': seconds});
    });
  }

  */
  Future<void> _updateNotification() async {
    final hours = (_seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((_seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'counter',
          'text',
          channelDescription: 'proceso',
          importance: Importance.low,
          priority: Priority.low,
          ongoing: true,
          showWhen: false,
        );

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'test',
      'tiempo: $hours:$minutes:$seconds',
      platformChannelSpecifics,
    );
  }

  void _startCounter(int id, int? idTask) {
    setState(() => _isRunning = true);
    _initTimer();
    _chronometerBloc.add(
      StartRecord(
        start: DateTime.now().toIso8601String(),
        id: id,
        idTask: idTask,
      ),
    );
  }

  void _initTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() => _seconds++);
    });
  }

  void _stopCounter(int id) {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _seconds = 0;
    });
    _chronometerBloc.add(
      StopRecord(id: id, finish: DateTime.now().toIso8601String()),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*
    if (_isRunning) {
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _seconds++;
        });
      });
    }
    */

    final hours = (_seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((_seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');

    final loc = AppLocalizations.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProjectChronometerBloc>(
          create: (context) => sl<ProjectChronometerBloc>()..add(GetProjects()),
        ),
        BlocProvider(create: (context) => _chronometerBloc..add(GetCurrent())),
      ],
      child: Scaffold(
        appBar: AppBarMain(
          title: loc?.translate('chronometer') ?? 'Chronometer',
        ),
        drawer: DrawerCustom(),
        body: ListView(
          children: [
            ClockCustom(hours: hours, minutes: minutes, seconds: seconds),
            BlocBuilder<ChronometerBloc, ChronometerState>(
              builder: (context, chronometerState) {
                if (chronometerState is ChronometerLoading) {
                  return PreLoader();
                } else if (chronometerState is ChronometerLoaded) {
                  return BlocBuilder<
                    ProjectChronometerBloc,
                    ProjectChronometerState
                  >(
                    builder: (context, state) {
                      if (chronometerState.record != null && !_hasCalculated) {
                        if (chronometerState.record?.idTask != null) {
                          context.read<ProjectChronometerBloc>().add(
                            InitProjectAndTask(
                              idProject:
                                  chronometerState.record?.idProject ?? 0,
                              idTask: chronometerState.record?.idTask ?? 0,
                            ),
                          );
                        } else {
                          context.read<ProjectChronometerBloc>().add(
                            SelectProject(
                              id: chronometerState.record?.idProject ?? 0,
                            ),
                          );
                        }

                        final lastSaved = DateTime.parse(
                          chronometerState.record?.start ?? '',
                        );
                        final now = DateTime.now();

                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted) {
                            setState(() {
                              _seconds = now.difference(lastSaved).inSeconds;
                              _isRunning = true;
                            });
                            _initTimer();
                          }
                        });
                      }
                      _hasCalculated = true;
                      if (state is ProjectChronometerLoading) {
                        return PreLoader();
                      } else if (state is ProjectChronometerLoaded) {
                        return Center(
                          child: GestureDetector(
                            onTap: () {
                              if (state.index != null) {
                                if (!_isRunning) {
                                  _startCounter(
                                    state.projects[state.index ?? 0].id,
                                    state.indexTask != null
                                        ? state.tasks![state.indexTask ?? 0].id
                                        : null,
                                  );
                                } else {
                                  _stopCounter(
                                    chronometerState.record?.id ?? 0,
                                  );
                                }
                              }
                            },
                            child: ButtonPausePlay(
                              running: _isRunning,
                              state: state.index != null,
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            SizedBox(height: 20),
            TitleChronometer(
              icon: CupertinoIcons.app,
              title: loc?.translate('project') ?? 'Project:',
            ),
            BlocBuilder<ProjectChronometerBloc, ProjectChronometerState>(
              builder: (context, state) {
                if (state is ProjectChronometerLoading) {
                  return PreLoader();
                } else if (state is ProjectChronometerLoaded) {
                  if (state.index == null) {
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return StatefulBuilder(
                              builder: (contextDialog, setState) {
                                return AlertDialog(
                                  title: Center(
                                    child: Text(
                                      loc?.translate('projects') ?? 'Projects',
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                      ),
                                    ),
                                  ),
                                  content: Container(
                                    width: double.maxFinite,
                                    height: 300,
                                    child: ListView(
                                      children: List.generate(
                                        state.projects.length,
                                        (i) {
                                          return CardProjectChronometer(
                                            title: state.projects[i].title,
                                            img: state.projects[i].image,
                                            function: () => {
                                              context
                                                  .read<
                                                    ProjectChronometerBloc
                                                  >()
                                                  .add(
                                                    SelectProject(
                                                      id: state.projects[i].id,
                                                    ),
                                                  ),
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 70,
                        margin: EdgeInsets.only(
                          right: 20,
                          left: 20,
                          top: 5,
                          bottom: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: BoxBorder.all(
                            width: 1,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            CupertinoIcons.add,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      height: 70,
                      margin: EdgeInsets.only(
                        right: 20,
                        left: 20,
                        top: 5,
                        bottom: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: BoxBorder.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image:
                                          !state
                                              .projects[state.index ?? 0]
                                              .image
                                              .contains(
                                                'lib/assets/img/example',
                                              )
                                          ? FileImage(
                                              File(
                                                state
                                                    .projects[state.index ?? 0]
                                                    .image,
                                              ),
                                            )
                                          : AssetImage(
                                              state
                                                  .projects[state.index ?? 0]
                                                  .image,
                                            ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    state.projects[state.index ?? 0].title,
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              !_isRunning
                                  ? GestureDetector(
                                      onTap: () {
                                        context
                                            .read<ProjectChronometerBloc>()
                                            .add(DeleteSelectProject());
                                      },
                                      child: Icon(
                                        CupertinoIcons.trash,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              SizedBox(width: 10),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            SizedBox(height: 20),
            BlocBuilder<ProjectChronometerBloc, ProjectChronometerState>(
              builder: (context, state) {
                if (state is ProjectChronometerLoading) {
                  return PreLoader();
                } else if (state is ProjectChronometerLoaded) {
                  if (state.indexTask != null) {
                    return Column(
                      children: [
                        TitleChronometer(
                          icon: CupertinoIcons.rectangle_paperclip,
                          title:
                              loc?.translate('task_optional') ??
                              'Task (optional):',
                        ),
                        Container(
                          height: 70,
                          margin: EdgeInsets.only(
                            right: 20,
                            left: 20,
                            top: 5,
                            bottom: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: BoxBorder.all(
                              width: 1,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        state.tasks![state.indexTask ?? 0].name,
                                        style: TextStyle(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  !_isRunning
                                      ? GestureDetector(
                                          onTap: () {
                                            context
                                                .read<ProjectChronometerBloc>()
                                                .add(DeleteTask());
                                          },
                                          child: Icon(
                                            CupertinoIcons.trash,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  SizedBox(width: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (state.index != null && !_isRunning) {
                    return Column(
                      children: [
                        TitleChronometer(
                          icon: CupertinoIcons.rectangle_paperclip,
                          title:
                              loc?.translate('task_optional') ??
                              'Task (optional):',
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (contextDialog) {
                                return StatefulBuilder(
                                  builder: (contextDialog, setState) {
                                    return AlertDialog(
                                      title: Center(
                                        child: Text(
                                          loc?.translate('title_task') ??
                                              'Tasks',
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.secondary,
                                          ),
                                        ),
                                      ),
                                      content: Container(
                                        width: double.maxFinite,
                                        height: 300,
                                        child: ListView(
                                          children: List.generate(
                                            state.tasks!.length,
                                            (i) {
                                              return GestureDetector(
                                                onTap: () {
                                                  context
                                                      .read<
                                                        ProjectChronometerBloc
                                                      >()
                                                      .add(
                                                        SelectTask(
                                                          id: state
                                                              .tasks![i]
                                                              .id,
                                                        ),
                                                      );
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(10),
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          5,
                                                        ),
                                                    border: BoxBorder.all(
                                                      width: 1,
                                                      color: Theme.of(
                                                        context,
                                                      ).colorScheme.secondary,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      state.tasks![i].name,
                                                      style: TextStyle(
                                                        color: Theme.of(
                                                          context,
                                                        ).colorScheme.secondary,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 70,
                            margin: EdgeInsets.only(
                              right: 20,
                              left: 20,
                              top: 5,
                              bottom: 5,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: BoxBorder.all(
                                width: 1,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                CupertinoIcons.add,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
