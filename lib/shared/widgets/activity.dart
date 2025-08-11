import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackbuzz/features/track/data/models/record_model.dart';
import 'package:trackbuzz/shared/functions/time_format_record.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

class Activity extends StatelessWidget {
  final List<RecordModel> dateList;

  const Activity({super.key, required this.dateList});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    final activityMap = <DateTime, int>{};
    final timeMap = <DateTime, int>{};
    for (var i = 0; i < dateList.length; i++) {
      final date = DateTime.parse(dateList[i].start);
      final normalizedDate = DateTime(date.year, date.month, date.day);
      activityMap[normalizedDate] = (activityMap[normalizedDate] ?? 0) + 1;
      timeMap[normalizedDate] =
          (timeMap[normalizedDate] ?? 0) +
          DateTime.parse(dateList[i].finish ?? '').difference(date).inSeconds;
    }

    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month - 11, 1);

    final weeks = <DateTime>[];
    var currentDate = _getPreviousMonday(startDate);
    while (currentDate.isBefore(now)) {
      weeks.add(currentDate);
      currentDate = currentDate.add(const Duration(days: 7));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth - 36;

        final weeksToShow = (availableWidth / 18).floor();

        final visibleWeeks = weeks.sublist(weeks.length - weeksToShow);

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(7, (index) {
                final weekday = [
                  loc?.translate('mon') ?? 'Mon',
                  loc?.translate('tue') ?? 'Tue',
                  loc?.translate('wed') ?? 'Wed',
                  loc?.translate('thu') ?? 'Thu',
                  loc?.translate('fri') ?? 'Fri',
                  loc?.translate('sat') ?? 'Sat',
                  loc?.translate('sun') ?? 'Sun',
                ][index];

                return Container(
                  height: 16,
                  width: 32,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 4),
                  margin: const EdgeInsets.only(top: 1, bottom: 1),
                  child: Text(
                    weekday,
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(width: 4),

            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(7, (rowIndex) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: visibleWeeks.map((weekStart) {
                      final dayDate = weekStart.add(Duration(days: rowIndex));

                      if (dayDate.isAfter(now)) {
                        return const SizedBox.shrink();
                      }

                      final activityCount = activityMap[dayDate] ?? 0;
                      final timeCount = timeMap[dayDate] ?? 0;
                      final color = _getColorForActivity(timeCount, context);

                      return Tooltip(
                        message: activityCount > 0
                            ? '${DateFormat('MMM d, y', loc?.locale.languageCode == 'en' ? 'en_US' : 'es_ES').format(dayDate)}\n'
                                  '${timeFormatRecord(timeCount)}\n'
                                  '$activityCount ${activityCount == 1 ? loc?.translate('activity') ?? 'activity' : loc?.translate('activities') ?? 'activities'}'
                            : '${loc?.translate('no_activity') ?? 'No activity on'} ${DateFormat('MMM d, y', loc?.locale.languageCode == 'en' ? 'en_US' : 'es_ES').format(dayDate)}',
                        textAlign: TextAlign.center,
                        child: Container(
                          width: 16,
                          height: 16,
                          margin: const EdgeInsets.all(1.1),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
              ),
            ),
          ],
        );
      },
    );
  }
}

DateTime _getPreviousMonday(DateTime date) {
  return date.subtract(Duration(days: date.weekday - 1));
}

Color _getColorForActivity(int count, context) {
  // nothing
  if (count == 0) return Theme.of(context).colorScheme.primary.withOpacity(0.1);
  // 10 minutes
  if (count <= 600)
    return Theme.of(context).colorScheme.primary.withOpacity(0.5);
  // 30 minutes
  if (count <= 1800)
    return Theme.of(context).colorScheme.primary.withOpacity(0.8);

  return Theme.of(context).colorScheme.primary;
}
