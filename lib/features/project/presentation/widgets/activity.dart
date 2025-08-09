import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

class Activity extends StatelessWidget {
  final List<String> dateStrings;

  const Activity({super.key, required this.dateStrings});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    final activityMap = <DateTime, int>{};
    for (var dateStr in dateStrings) {
      final date = DateTime.parse(dateStr);
      final normalizedDate = DateTime(date.year, date.month, date.day);
      activityMap[normalizedDate] = (activityMap[normalizedDate] ?? 0) + 1;
    }

    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month - 11, 1);

    final weeks = <DateTime>[];
    var currentDate = _getPreviousMonday(startDate);
    while (currentDate.isBefore(now)) {
      weeks.add(currentDate);
      currentDate = currentDate.add(const Duration(days: 7));
    }

    final currentWeekday = now.weekday % 7;

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
                if (index > currentWeekday) return const SizedBox.shrink();

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
                  if (rowIndex > currentWeekday) return const SizedBox.shrink();

                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: visibleWeeks.map((weekStart) {
                      final dayDate = weekStart.add(Duration(days: rowIndex));
                      if (dayDate.isAfter(now)) return const SizedBox.shrink();

                      final activityCount = activityMap[dayDate] ?? 0;
                      final color = _getColorForActivity(
                        activityCount,
                        context,
                      );

                      return Tooltip(
                        message: activityCount > 0
                            ? '${DateFormat('MMM d, y', loc?.locale.languageCode == 'en' ? 'en_US' : 'es_ES').format(dayDate)}\n'
                                  '$activityCount ${activityCount == 1 ? loc?.translate('activity') ?? 'activity' : loc?.translate('activities') ?? 'activities'}'
                            : '${loc?.translate('no_activity') ?? 'No activity on'} ${DateFormat('MMM d, y', loc?.locale.languageCode == 'en' ? 'en_US' : 'es_ES').format(dayDate)}',
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
  if (count == 0) return Theme.of(context).colorScheme.primary.withOpacity(0.1);
  if (count <= 2) return Theme.of(context).colorScheme.primary.withOpacity(0.3);
  if (count <= 5) return Theme.of(context).colorScheme.primary.withOpacity(0.5);
  return Theme.of(context).colorScheme.primary.withOpacity(1);
}
