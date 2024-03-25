import 'package:flutter/material.dart';
import 'package:namer_app/logic/wordlink_logic.dart';
import 'package:namer_app/widgets/custom_app_bar.dart';
import 'styles.dart';
import 'package:namer_app/translations/my_localizations.dart';
import 'widgets/game_dialog.dart';
import 'package:namer_app/widgets/big_card.dart';

class WordLinkPage extends StatefulWidget {
  @override
  State<WordLinkPage> createState() => _WordLinkPageState();
}

class _WordLinkPageState extends State<WordLinkPage> {
  WordLinkLogic logic = WordLinkLogic();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    logic = WordLinkLogic(
      onStateChanged: () {
        if (mounted) setState(() {});
      },
      onSuccess: (context) => _handleGameSuccess(context),
      onTimeUp: (context) => _handleTimeUp(context),
    );
  }

  // Show a success dialog
  void _handleGameSuccess(BuildContext context) {
    showGameDialog(
      context: context,
      type: DialogType.success,
      onRestart: () => restartGame(),
    );
  }

  // Show a time up dialog
  void _handleTimeUp(BuildContext context) {
    showGameDialog(
      context: context,
      type: DialogType.timeUp,
      onRestart: () => restartGame(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeGame();
  }

  Future<void> _initializeGame() async {
    var locale = Localizations.localeOf(context);
    logic.langCode = locale.languageCode;
    await logic.apiService.loadDictionary(logic.langCode);
    if (!mounted) return;
    setState(() {
      logic.fetchWords(logic.langCode, context).then((_) {
        if (mounted) {
          logic.startTimer(() => _handleTimeUp(context));
        }
      });
    });
  }

  // Restart the game after the user has pressed the "restart" button
  void restartGame() {
    Navigator.of(context).pop();
    setState(() {
      logic.restartGame();
    });
    logic.fetchWords(logic.langCode, context);
    logic.startTimer(() => _handleTimeUp(context));
  }

  @override
  Widget build(BuildContext context) {
    var localizations = MyLocalizations.of(context)!;

    // While the words are being fetched, show loading screens
    if (logic.isLoadingWords) {
      return Scaffold(
        appBar: CustomAppBar(titleText: localizations.strings.wl_title),
        backgroundColor: backgroundColor,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        titleText: localizations.strings.wl_title,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                // Timer
                SizedBox(
                  width: 36,
                  height: 36,
                  child: CircularProgressIndicator(
                    value: 1 - logic.timerProgress,
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    strokeWidth: 3,
                  ),
                ),
                Text(
                  '${logic.remainingTime}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: BigCard(
                text: localizations.strings.wl_start, word: logic.startWord),
          ),
          BigCard(text: localizations.strings.wl_end, word: logic.endWord),
          Expanded(
            // Path words
            child: ListView.builder(
              itemCount: logic.transformationSteps.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      logic.transformationSteps[index],
                      style: subtitlePaleTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ),
          // Error messages
          if (logic.errorMessage.isNotEmpty)
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                logic.errorMessage,
                style: errorTextStyle,
              ),
            ),
          // Input and button to submit word
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _controller,
              decoration: inputDecoration(
                  hintText: localizations.strings.wl_enter_word),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => logic.addStep(_controller, context),
              style: buttonStyle,
              child: Text(localizations.strings.wl_submit),
            ),
          ),
        ],
      ),
    );
  }
}
