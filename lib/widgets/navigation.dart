import 'package:flutter/material.dart';
import 'package:namer_app/home_page.dart';
import 'package:namer_app/settings_page.dart';
import 'package:namer_app/wordlink_page.dart';
import 'package:namer_app/translations/my_localizations.dart';

class Navigation extends StatefulWidget {
  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final localizations = MyLocalizations.of(context)!;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomePage();
        break;
      case 1:
        page = SettingsPage();
        break;
      case 2:
        page = WordLinkPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text(localizations.strings.home_title),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.settings),
                      label: Text(localizations.strings.settings_title),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.type_specimen_sharp),
                      label: Text(localizations.strings.wl_title),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
