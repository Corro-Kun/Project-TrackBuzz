import 'package:flutter/material.dart';
import 'package:trackbuzz/utils/l10n/app_localizations_en.dart';
import 'package:trackbuzz/utils/l10n/app_localizations_es.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Map<String, String>? _localizedStrings;

  Future<bool> load() async {
    switch (locale.languageCode) {
      case 'es':
        _localizedStrings = AppLocalizationsEs.values;
        break;
      case 'en':
      default:
        _localizedStrings = AppLocalizationsEn.values;
    }
    return true;
  }

  String translate(String key) {
    return _localizedStrings?[key] ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(covariant Locale locale) {
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
