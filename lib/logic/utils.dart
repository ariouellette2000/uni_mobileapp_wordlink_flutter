import 'dart:math';
import 'package:flutter/services.dart';
import 'dart:convert';

class ApiService {
  List<String>? _dictionary;

  // Load the dictionary associate with the choosen langage from assets
  Future<void> loadDictionary(String lang) async {
    String dictString = '';
    if (lang == 'en') {
      dictString = await rootBundle.loadString('assets/dictionary.txt');
    } else {
      dictString = await rootBundle.loadString('assets/dictionnaire.txt');
    }
    _dictionary = LineSplitter().convert(dictString.toLowerCase());
  }

  // Perform a binary search on the loaded dictionary
  int binarySearch(String word) {
    int start = 0;
    int end = _dictionary!.length - 1;

    while (start <= end) {
      int mid = start + ((end - start) >> 1);
      String midValue = _dictionary![mid];

      if (midValue == word) {
        return mid;
      } else if (midValue.compareTo(word) < 0) {
        start = mid + 1;
      } else {
        end = mid - 1;
      }
    }
    return -1;
  }

  // Verify the word is in the dictionary
  bool isWordInList(String word) {
    return binarySearch(word) != -1;
  }

  // Fetch the end word randomly in the dictionary
  Future<String> fetchEndWord(String lang, int lengthOfWord) async {
    final String filePath =
        lang == 'fr' ? 'assets/dictionnaire.txt' : 'assets/dictionary.txt';
    String content = await rootBundle.loadString(filePath);
    final List<String> lines =
        content.split('\n').map((word) => word.trim()).toList();
    print('5: $lengthOfWord');
    final List<String> validWords = lines
        .where((word) =>
            word.length == lengthOfWord && word.codeUnits.every((c) => c < 128))
        .toList();
    if (validWords.isEmpty) {
      return 'Erreur';
    }
    final Random random = Random();
    final String randomWord =
        validWords[random.nextInt(validWords.length)].toLowerCase();
    return randomWord.toLowerCase();
  }

  // Fetch the start word, by looking at the path from the end word
  Future<List<String>> fetchStartWord(String lang, String endWord) async {
    String currentWord = endWord;
    bool validShorterWordFound = true;

    // Loop to find a path to the smallest start word removing one letter at a time, and keeping all node words valids
    while (currentWord.length > 2 &&
        validShorterWordFound &&
        (endWord.length - currentWord.length < 2)) {
      validShorterWordFound = false;
      for (int i = 0; i < currentWord.length; i++) {
        String testWord =
            currentWord.substring(0, i) + currentWord.substring(i + 1);
        if (isWordInList(testWord)) {
          currentWord = testWord.toLowerCase();
          validShorterWordFound = true;
          break;
        }
      }
      // No possible path found, regenerate an end word
      if (!validShorterWordFound || currentWord.length <= 2) {
        String newEndWord = await fetchEndWord(lang, endWord.length);
        return await fetchStartWord(lang, newEndWord);
      }
    }
    return [endWord, currentWord];
  }

  // Verify that the newWord contains all letters in order from the lastword
  bool containsAllLettersInOrder(String lastWord, String newWord) {
    int j = 0;
    for (int i = 0; i < newWord.length && j < lastWord.length; i++) {
      if (newWord[i] == lastWord[j]) {
        j++;
      }
    }
    return j == lastWord.length;
  }
}
