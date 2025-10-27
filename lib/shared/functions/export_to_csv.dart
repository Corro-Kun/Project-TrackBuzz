import 'dart:io';

Future<String> exportToCsv(List<Map<String, dynamic>> data, String path) async {
  final columns = data.first.keys.toList();

  final StringBuffer csvContent = StringBuffer();

  csvContent.write(columns.join(','));
  csvContent.write('\n');

  for (final row in data) {
    final List<String> values = [];

    for (final column in columns) {
      final value = row[column]?.toString() ?? '';
      final escapedValue = _escapeCsvValue(value);
      values.add(escapedValue);
    }

    csvContent.write(values.join(','));
    csvContent.write('\n');
  }

  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final file = File('$path/export_$timestamp.csv');

  await file.writeAsString(csvContent.toString(), flush: true);

  return file.path;
}

String _escapeCsvValue(String value) {
  if (value.contains(',') || value.contains('"') || value.contains('\n')) {
    value = value.replaceAll('"', '""');
    return '"$value"';
  }
  return value;
}
