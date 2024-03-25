import 'dart:async';
import 'package:flutter/material.dart';
import 'package:namer_app/translations/my_localizations.dart';
import 'utils.dart';

class WordLinkLogic {
  final ApiService apiService = ApiService();
  List<String> transformationSteps = [];
  String startWord = '';
  String endWord = '';
  int level = 5;
  String errorMessage = '';
  String langCode = '';
  Timer? gameTimer;
  int remainingTime = 120;
  double get timerProgress => remainingTime / 120.0;
  bool isLoadingWords = true;

  VoidCallback? onStateChanged;

  Function(BuildContext)? onSuccess;
  Function(BuildContext)? onTimeUp;

  WordLinkLogic({this.onStateChanged, this.onSuccess, this.onTimeUp});

  // Fetch the start and the end word
  Future<void> fetchWords(String langCode, BuildContext context) async {
    try {
      isLoadingWords = true;
      String fetchedEndWord = await apiService.fetchEndWord(langCode, level);
      final words = await apiService.fetchStartWord(langCode, fetchedEndWord);
      startWord = words[1];
      endWord = words[0];
      errorMessage = '';
      isLoadingWords = false;
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  // Start the timer, and save the remaining time
  void startTimer(VoidCallback onTimeUp) {
    remainingTime = 120;
    gameTimer?.cancel();
    gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime--;
        onStateChanged?.call();
      } else {
        gameTimer?.cancel();
        if (onTimeUp != null) {
          onTimeUp();
        }
      }
    });
  }

  // Verify that the enteredWord is valid
  bool isValidStep(BuildContext context, String newWord) {
    String lastWord =
        transformationSteps.isNotEmpty ? transformationSteps.last : startWord;

    // The word is longuer than the previous
    if (newWord.length != lastWord.length + 1) {
      errorMessage = MyLocalizations.of(context)!.strings.wl_err_one_letter;
      return false;
    }

    // The word contains all letters in order compare to the last one
    if (!apiService.containsAllLettersInOrder(lastWord, newWord)) {
      errorMessage = MyLocalizations.of(context)!.strings.wl_err_contain_all;
      return false;
    }

    // The word exists in the dictionary
    if (!apiService.isWordInList(newWord)) {
      errorMessage = MyLocalizations.of(context)!.strings.wl_err_not_valid;
      return false;
    }

    errorMessage = '';
    return true;
  }

  // Add the new valid entered word to the list (path)
  void addStep(TextEditingController controller, BuildContext context) {
    String newWord = controller.text;
    if (isValidStep(context, newWord)) {
      transformationSteps.add(newWord);
      errorMessage = '';
      controller.clear();

      if (newWord.toLowerCase() == endWord.toLowerCase()) {
        if (onSuccess != null) {
          onSuccess!(context);
        }
      }
    }
  }

  // Restart the game, reset the transformation steps
  void restartGame() {
    transformationSteps.clear();
    errorMessage = '';
    isLoadingWords = true;
  }
}
