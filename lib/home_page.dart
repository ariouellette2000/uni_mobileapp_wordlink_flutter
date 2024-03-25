import 'package:flutter/material.dart';
import 'package:namer_app/translations/my_localizations.dart';
import 'package:namer_app/widgets/big_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = MyLocalizations.of(context)!;

    return Scaffold(
      backgroundColor:
          Theme.of(context).colorScheme.background, // Set background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigCard(
                text: localizations.strings.welcome,
                word: localizations.strings.player),
          ],
        ),
      ),
    );
  }
}
