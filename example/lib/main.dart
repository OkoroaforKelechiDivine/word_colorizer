import 'package:flutter/material.dart';
import 'package:word_colorizer/word_colorizer.dart';

void main() {
  runApp(const WordColorizerApp());
}

class WordColorizerApp extends StatelessWidget {
  const WordColorizerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Word Colorizer Demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Word Colorizer Example'),
          backgroundColor: Colors.teal,
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: WordColorizer(
              text: "Flutter is powerful, open source, and fun!",
              highlightWordsWithColors: {
                "Flutter": Colors.blue,
                "open source": Colors.green,
                "fun": Colors.orange,
              },
              defaultColor: Colors.grey,
              textAlign: TextAlign.left,
              fontSize: 20,
              fontFamily: "google.Nunito",
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              isHighlightClickable: true,
              onHighlightTap: {
                "Flutter": _onFlutterTap,
                "open source": _onOpenSourceTap,
                "fun": _onFunTap,
              },
            ),
          ),
        ),
      ),
    );
  }

  static void _onFlutterTap() {
    debugPrint("Flutter tapped! Magic enabled.");
  }

  static void _onOpenSourceTap() {
    debugPrint("Open source tapped! Community power.");
  }

  static void _onFunTap() {
    debugPrint("Fun tapped! Let's party!");
  }
}
