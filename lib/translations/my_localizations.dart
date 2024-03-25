import 'package:flutter/material.dart';
import 'en.dart';
import 'fr.dart';

class MyLocalizations {
  final Locale locale;
  MyLocalizations(this.locale);

  static MyLocalizations? of(BuildContext context) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations);
  }

  static Map<String, dynamic> _localizedValues = {
    'en': EnStrings(),
    'fr': FrStrings(),
  };

  dynamic get strings {
    return _localizedValues[locale.languageCode];
  }
}

class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  @override
  bool isSupported(Locale locale) => ['en', 'fr'].contains(locale.languageCode);

  @override
  Future<MyLocalizations> load(Locale locale) async {
    MyLocalizations localizations = MyLocalizations(locale);
    return localizations;
  }

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;
}
