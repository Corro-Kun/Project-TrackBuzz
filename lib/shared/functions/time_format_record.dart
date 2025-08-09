String timeFormatRecord(int seconds) {
  final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
  final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
  final second = (seconds % 60).toString().padLeft(2, '0');

  return '$hours:$minutes:$second';
}
