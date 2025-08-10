import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:trackbuzz/core/di/injection_container.dart';
import 'package:trackbuzz/features/project/presentation/bloc/Project/project_bloc.dart';
import 'package:trackbuzz/features/project/presentation/bloc/Project/project_event.dart';
import 'package:trackbuzz/features/project/presentation/bloc/Project/project_state.dart';
import 'package:trackbuzz/features/project/presentation/bloc/Record/record_bloc.dart';
import 'package:trackbuzz/features/project/presentation/bloc/Record/record_event.dart';
import 'package:trackbuzz/features/project/presentation/bloc/Record/record_state.dart';
import 'package:trackbuzz/features/project/presentation/bloc/SettingProject/setting_project_bloc.dart';
import 'package:trackbuzz/features/project/presentation/bloc/SettingProject/setting_project_event.dart';
import 'package:trackbuzz/features/project/presentation/bloc/SettingProject/setting_project_state.dart';
import 'package:trackbuzz/features/project/presentation/widgets/activity.dart';
import 'package:trackbuzz/features/project/presentation/widgets/app_bar_information.dart';
import 'package:trackbuzz/features/project/presentation/widgets/date_widget.dart';
import 'package:trackbuzz/features/project/presentation/widgets/picture_project.dart';
import 'package:trackbuzz/features/project/presentation/widgets/drawer_setting.dart';
import 'package:trackbuzz/features/project/presentation/widgets/time_widget.dart';
import 'package:trackbuzz/shared/functions/time_format_record.dart';
import 'package:trackbuzz/shared/widgets/pre_loader.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

class ProjectInformation extends StatefulWidget {
  final int id;
  const ProjectInformation({super.key, required this.id});

  static Route<void> route(int id) {
    return MaterialPageRoute(builder: (context) => ProjectInformation(id: id));
  }

  @override
  State<ProjectInformation> createState() => _ProjectInformationState();
}

class _ProjectInformationState extends State<ProjectInformation>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProjectBloc>(
          create: (context) =>
              sl<ProjectBloc>()..add(GetProject(id: widget.id)),
        ),
        BlocProvider<SettingProjectBloc>(
          create: (context) =>
              sl<SettingProjectBloc>()..add(GetSetting(id: widget.id)),
        ),
        BlocProvider<RecordBloc>(
          create: (context) => sl<RecordBloc>()..add(GetRecord(id: widget.id)),
        ),
      ],
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: BlocBuilder<ProjectBloc, ProjectState>(
            builder: (context, state) {
              String title = '...';
              bool update = false;
              if (state is ProjectLoaded) {
                title = state.project.title;
                update = state.update;
              }
              return AppBarInformation(title: title, update: update);
            },
          ),
        ),
        drawer: DrawerSettingBloc(id: widget.id),
        body: Column(
          children: [
            Container(
              height: 300,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<ProjectBloc, ProjectState>(
                      builder: (context, state) {
                        if (state is ProjectLoading) {
                          return PreLoader();
                        } else if (state is ProjectLoaded) {
                          return PictureProject(img: state.project.image);
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                    SizedBox(height: 25),
                    BlocBuilder<RecordBloc, RecordState>(
                      builder: (context, state) {
                        if (state is RecordLoading) {
                          return PreLoader();
                        } else if (state is RecordLoaded) {
                          int seconds = 0;
                          for (var i = 0; i < state.records.length; i++) {
                            final finishSaved = DateTime.parse(
                              state.records[i].finish ?? '',
                            );
                            seconds += finishSaved
                                .difference(
                                  DateTime.parse(state.records[i].start),
                                )
                                .inSeconds;
                          }
                          return Text(
                            timeFormatRecord(seconds),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: TabBar(
                controller: _tabController,
                dividerHeight: 0,
                indicatorColor: Theme.of(context).colorScheme.primary,
                labelColor: Theme.of(context).colorScheme.primary,
                unselectedLabelColor: Theme.of(context).colorScheme.secondary,
                tabs: [
                  Tab(text: loc?.translate('general') ?? 'General'),
                  Tab(text: loc?.translate('record') ?? 'Record'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  listViewGeneral(context, loc),
                  BlocBuilder<RecordBloc, RecordState>(
                    builder: (context, state) {
                      if (state is RecordLoading) {
                        return PreLoader();
                      } else if (state is RecordLoaded) {
                        List<String> totals = [];
                        int secondsTemp = 0;
                        String currentTemp = '';

                        for (var i = 0; i < state.records.length; i++) {
                          final startSaved = DateTime.parse(
                            state.records[i].start,
                          );
                          final date = DateFormat(
                            "EEEE, d MMMM yyyy",
                            'es_ES',
                          ).format(startSaved);
                          final finishSaved = DateTime.parse(
                            state.records[i].finish ?? '',
                          );

                          if (currentTemp.isEmpty) {
                            currentTemp = date;
                          } else if (currentTemp != date) {
                            totals.add(timeFormatRecord(secondsTemp));
                            currentTemp = date;
                            secondsTemp = 0;
                          } else if (state.records.length - 1 == i) {
                            secondsTemp += finishSaved
                                .difference(startSaved)
                                .inSeconds;
                            totals.add(timeFormatRecord(secondsTemp));
                            break;
                          }

                          secondsTemp += finishSaved
                              .difference(startSaved)
                              .inSeconds;

                          if (state.records.length == 1) {
                            totals.add(timeFormatRecord(secondsTemp));
                          }
                        }
                        String current = '';
                        int countTotals = 0;
                        final data = List.generate(state.records.length, (i) {
                          final startSaved = DateTime.parse(
                            state.records[i].start,
                          );
                          final date = DateFormat(
                            "EEEE, d MMMM yyyy",
                            loc?.locale.languageCode == 'en'
                                ? 'en_US'
                                : 'es_ES',
                          ).format(startSaved);

                          final finishSaved = DateTime.parse(
                            state.records[i].finish ?? '',
                          );

                          final int seconds = finishSaved
                              .difference(startSaved)
                              .inSeconds;

                          if (current.isEmpty || current != date) {
                            current = date;
                            final widget = Column(
                              children: [
                                DateWidget(
                                  date: date,
                                  total: totals[countTotals],
                                ),
                                TimeWidget(
                                  name: 'General',
                                  time: timeFormatRecord(seconds),
                                ),
                              ],
                            );
                            countTotals++;
                            return widget;
                          } else {
                            return TimeWidget(
                              name: 'General',
                              time: timeFormatRecord(seconds),
                            );
                          }
                        });
                        return ListView(children: data);
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {},
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            CupertinoIcons.rectangle_stack_fill_badge_plus,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }

  ListView listViewGeneral(BuildContext context, AppLocalizations? loc) {
    return ListView(
      children: [
        BlocBuilder<SettingProjectBloc, SettingProjectState>(
          builder: (contextBloc, state) {
            if (state is SettingProjectLoading) {
              return PreLoader();
            } else if (state is SettingProjectLoaded) {
              final List<Widget> list = [
                Container(
                  margin: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.money_dollar_circle,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      SizedBox(width: 5),
                      Text(
                        loc?.translate('billing') ?? 'Billing:',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
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
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Center(
                    child: Text(
                      r'$43',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ];
              return state.setting.bill == 1
                  ? Column(children: list)
                  : SizedBox.shrink();
            } else {
              return SizedBox.shrink();
            }
          },
        ),
        Container(
          margin: EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(
                CupertinoIcons.calendar,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(width: 5),
              Text(
                loc?.translate('days') ?? 'Days:',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<RecordBloc, RecordState>(
          builder: (context, state) {
            if (state is RecordLoading) {
              return PreLoader();
            } else if (state is RecordLoaded) {
              return Padding(
                padding: EdgeInsets.only(
                  right: 20,
                  left: 20,
                  top: 5,
                  bottom: 5,
                ),
                child: Activity(dateList: state.records),
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
        Container(
          margin: EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(
                CupertinoIcons.rectangle_paperclip,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(width: 5),
              Text(
                loc?.translate('tasks') ?? 'Tasks:',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DrawerSettingBloc extends StatelessWidget {
  final int id;
  const DrawerSettingBloc({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return DrawerSetting(
      settingProjectBloc: context.read<SettingProjectBloc>(),
      projectBloc: context.read<ProjectBloc>(),
      idProject: id,
    );
  }
}
