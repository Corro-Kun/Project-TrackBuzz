import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<String> exportToCsv(List<Map<String, dynamic>> data) async {
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

  final String stringData = csvContent.toString();

  final List<int> bytes = utf8.encode(stringData);

  final Uint8List uint8list = Uint8List.fromList(bytes);

  final timestamp = DateTime.now().millisecondsSinceEpoch;

  String? directorySelect = await FilePicker.platform.saveFile(
    bytes: uint8list,
    fileName: 'export_$timestamp.csv',
  );

  final dir = await getExternalStorageDirectory();

  return '${dir!.path.substring(0, dir.path.indexOf('Android'))}${directorySelect!.substring(directorySelect.indexOf(':') + 1)}';
}

String _escapeCsvValue(String value) {
  if (value.contains(',') || value.contains('"') || value.contains('\n')) {
    value = value.replaceAll('"', '""');
    return '"$value"';
  }
  return value;
}
