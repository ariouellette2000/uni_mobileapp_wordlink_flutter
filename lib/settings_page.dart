import 'package:flutter/material.dart';
import 'package:namer_app/styles.dart';
import 'package:namer_app/translations/my_localizations.dart';
import 'package:namer_app/widgets/custom_app_bar.dart';
import 'package:namer_app/logic/settings_logic.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? _selectedLanguage = 'en';
  bool _userLovesApp = false;
  late final SettingsLogic _settingsLogic;

  @override
  void initState() {
    super.initState();
    _settingsLogic = SettingsLogic(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_selectedLanguage == null) {
      setState(() {
        _selectedLanguage = Localizations.localeOf(context).languageCode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var localizations = MyLocalizations.of(context)!;
    final List<Map<String, String>> languages = _settingsLogic.getLanguages();

    return Scaffold(
      appBar: CustomAppBar(titleText: localizations.strings.settings_title),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(localizations.strings.settings_language,
                    style: subtitlePaleTextStyle)),
            // Choose languages dropdown
            DropdownButtonFormField<String>(
              decoration: inputDecoration(),
              value: _selectedLanguage,
              onChanged: (newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
              },
              dropdownColor: secondaryColor,
              items: languages.map((language) {
                return DropdownMenuItem<String>(
                  value: language['code'],
                  child: Row(
                    children: [
                      Image.asset(language['flag']!, width: 24, height: 24),
                      SizedBox(width: 8),
                      Text(language['name']!,
                          style: TextStyle(color: primaryColor)),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(localizations.strings.settings_feedback,
                    style: subtitlePaleTextStyle)),
            // Personnalized dictionary option
            CheckboxListTile(
              title: Text(localizations.strings.settings_love_app),
              value: _userLovesApp,
              onChanged: (bool? value) {
                setState(() {
                  _userLovesApp = value!;
                });
              },
            ),
            if (_userLovesApp)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  decoration: inputDecoration(
                      hintText: localizations.strings.settings_fb_comments),
                  onChanged: (value) {},
                ),
              ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () =>
                      _settingsLogic.applySetting(_selectedLanguage),
                  style: buttonStyle,
                  child: Text(localizations.strings.settings_apply),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
