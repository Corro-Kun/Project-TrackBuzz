import 'package:flutter/foundation.dart';

class AppReloader extends ChangeNotifier {
  Key _appKey = UniqueKey();
  Key get appKey => _appKey;

  static AppReloader? _instance;

  AppReloader._internal();

  factory AppReloader() {
    _instance ??= AppReloader._internal();
    return _instance!;
  }

  void reloadApp() {
    _appKey = UniqueKey();
    notifyListeners();
  }
}
