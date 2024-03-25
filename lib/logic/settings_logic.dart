import 'package:flutter/material.dart';
import 'package:namer_app/main.dart';
import 'package:namer_app/translations/my_localizations.dart';

class SettingsLogic {
  final BuildContext context;

  SettingsLogic(this.context);

  // Apply the settings to the entire app
  void applySetting(String? selectedLanguage) {
    Locale newLocale;
    switch (selectedLanguage) {
      case 'fr':
        newLocale = Locale('fr', '');
        break;
      case 'en':
      default:
        newLocale = Locale('en', '');
        break;
    }
    MyApp.setLocale(context, newLocale);
  }

  // Initiate a languages with the according text and image for the dropdowns
  List<Map<String, String>> getLanguages() {
    var localizations = MyLocalizations.of(context)!;
    return [
      {
        'code': 'en',
        'name': localizations.strings.settings_en,
        'flag': 'assets/english_flag.png'
      },
      {
        'code': 'fr',
        'name': localizations.strings.settings_fr,
        'flag': 'assets/french_flag.png'
      },
    ];
  }
}
