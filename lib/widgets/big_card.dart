import 'package:flutter/material.dart';
import 'package:namer_app/styles.dart';

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.text,
    required this.word,
  });

  final String word;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: secondaryColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text("$text $word", style: titleTextStyle),
      ),
    );
  }
}
