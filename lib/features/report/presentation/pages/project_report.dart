import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackbuzz/core/di/injection_container.dart';
import 'package:trackbuzz/features/project/data/models/activity_model.dart';
import 'package:trackbuzz/features/report/presentation/bloc/report/report_bloc.dart';
import 'package:trackbuzz/features/report/presentation/bloc/report/report_event.dart';
import 'package:trackbuzz/features/report/presentation/bloc/report/report_state.dart';
import 'package:trackbuzz/features/track/data/models/record_model.dart';
import 'package:trackbuzz/shared/functions/time_format_record.dart';
import 'package:trackbuzz/shared/widgets/activity.dart';
import 'package:trackbuzz/shared/widgets/adjustments_announced.dart';
import 'package:trackbuzz/shared/widgets/app_bar_main.dart';
import 'package:trackbuzz/shared/widgets/drawer_custom.dart';
import 'package:trackbuzz/shared/widgets/pre_loader.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

class ProjectReport extends StatelessWidget {
  const ProjectReport({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BlocProvider(
      create: (context) => sl<ReportBloc>()..add(GetReports()),
      child: Scaffold(
        appBar: AppBarMain(title: loc?.translate('reports') ?? 'Reports'),
        drawer: const DrawerCustom(),
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: AdjustmentsAnnounced(
                icon: CupertinoIcons.alarm,
                text: loc?.translate('total') ?? 'Total:',
              ),
            ),
            Container(
              height: 70,
              margin: const EdgeInsets.only(right: 20, left: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: BlocBuilder<ReportBloc, ReportState>(
                  builder: (context, state) {
                    if (state is ReportLoading) {
                      return const PreLoader();
                    } else if (state is ReportLoaded) {
                      return Text(
                        timeFormatRecord(state.seconds),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: AdjustmentsAnnounced(
                icon: CupertinoIcons.calendar,
                text: loc?.translate('activity_report') ?? 'Activity:',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20),
              child: BlocBuilder<ReportBloc, ReportState>(
                builder: (context, state) {
                  if (state is ReportLoading) {
                    return const PreLoader();
                  } else if (state is ReportLoaded) {
                    final date = List.generate(state.reports.length, (i) {
                      return ActivityModel(
                        id: state.reports[i].id,
                        activity: state.reports[i].activity,
                        date: state.reports[i].date,
                        second: state.reports[i].second,
                        idProject: state.reports[i].idProject,
                      );
                    });
                    return Activity(dateList: date);
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
            BlocBuilder<ReportBloc, ReportState>(
              builder: (context, state) {
                if (state is ReportLoading) {
                  return const PreLoader();
                } else if (state is ReportLoaded) {
                  if (state.seconds != 0) {
                    return Column(
                      children: [
                        state.totals.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.all(20),
                                child: AdjustmentsAnnounced(
                                  icon: CupertinoIcons.circle_grid_hex_fill,
                                  text:
                                      loc?.translate('percentage_report') ??
                                      'Percentage:',
                                ),
                              )
                            : const SizedBox.shrink(),
                        Column(
                          children: List.generate(state.totals.length, (i) {
                            return Container(
                              height: 70,
                              margin: const EdgeInsets.only(
                                right: 20,
                                left: 20,
                                top: 5,
                                bottom: 5,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: BoxBorder.all(
                                  width: 1,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 10),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            image: DecorationImage(
                                              image:
                                                  !state.totals[i].image
                                                      .contains(
                                                        'lib/assets/img/example',
                                                      )
                                                  ? FileImage(
                                                      File(
                                                        state.totals[i].image,
                                                      ),
                                                    )
                                                  : AssetImage(
                                                      state.totals[i].image,
                                                    ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            state.totals[i].title,
                                            style: TextStyle(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.secondary,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${((state.totals[i].second / state.seconds) * 100).toStringAsFixed(1)}%',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
