import 'dart:async';

import 'package:do_an_tong_hop/localization/flutter_localizations.dart';
import 'package:flutter/material.dart';

class FlutterLocalizationsDelegate
    extends LocalizationsDelegate<FlutterLocalizations> {
  static List<Locale> get supportedLocales => [
        const Locale('vi', 'VN'),
        const Locale('en', 'US'),
      ];

  final bool isTest;

  const FlutterLocalizationsDelegate({
    this.isTest = false,
  });

  @override
  bool isSupported(Locale locale) {
    return [
      'en',
      'vi',
    ].contains(locale.languageCode);
  }

  @override
  Future<FlutterLocalizations> load(Locale locale) async {
    FlutterLocalizations localizations = new FlutterLocalizations(locale);
    await localizations.loadString();
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<FlutterLocalizations> old) {
    return false;
  }
}
