import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  Locale? locale;
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
  late Map<String, String> jsonStrings;

  Future loadLang() async {
    String langFilePath = await rootBundle
        .loadString('assets/localization/${locale!.languageCode}.json');
    Map<String, dynamic> decodedJson = json.decode(langFilePath);
    jsonStrings = decodedJson.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  String translate(String key) {
    return jsonStrings[key] ?? 'No localization found for $key';
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations appLocalizations = AppLocalizations(locale);
    await appLocalizations.loadLang();
    return appLocalizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
