import 'package:flutter/material.dart';
import 'package:namer_app/translations/my_localizations.dart';
import 'package:provider/provider.dart';
import 'styles.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:namer_app/widgets/navigation.dart';

void main() {
  runApp(
    ChangeNotifierProvider<MyAppState>(
      create: (context) => MyAppState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        locale: _locale,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate, 
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          MyLocalizationsDelegate(),
        ],
        supportedLocales: [
          Locale('en', ''), // English
          Locale('fr', ''), // French
        ],

        title: 'WordLink App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor,
            primary: primaryColor,
            secondary: secondaryColor,
            background: backgroundColor,
          ),
        ),
        home: Navigation(),
      );
  }
}

class MyAppState extends ChangeNotifier {}