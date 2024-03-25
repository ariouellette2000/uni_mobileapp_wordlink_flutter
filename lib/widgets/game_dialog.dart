import 'package:flutter/material.dart';
import 'package:namer_app/translations/my_localizations.dart';

enum DialogType { success, timeUp }

void showGameDialog({
  required BuildContext context,
  required DialogType type,
  required VoidCallback onRestart,
}) {
  var localizations = MyLocalizations.of(context)!;

  // It could be a "success" or a "time up" pop up
  String title, content;
  switch (type) {
    case DialogType.success:
      title = localizations.strings.wl_success;
      content = localizations.strings.wl_success_message;
      break;
    case DialogType.timeUp:
      title = localizations.strings.wl_time_up;
      content = localizations.strings.wl_lost_game;
      break;
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          ElevatedButton(
            onPressed: onRestart,
            child: Text(localizations.strings.wl_restart),
          ),
        ],
      );
    },
  );
}
