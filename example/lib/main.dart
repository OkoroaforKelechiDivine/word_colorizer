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
              text: 'I am Kelechi Divine, the creator of zipDemon, easy_carousel, word_colorizer and Nzinger and I wrote those codes in Flutter with style and grace!',
              highlightWordsWithColors: {
                'zipDemon': Colors.green,
                'Flutter': Colors.blue,
                'grace': Colors.purple,
              },
              fontFamily: 'Google.Macondo',
              fontSize: 22,
              isHighlightClickable: true,
              onHighlightTap: {
                'ZipDmone': _onZipTap,
                'Flutter': _onFlutterTap,
              },
            ),
          ),
        ),
      ),
    );
  }

  static void _onZipTap() {
    debugPrint("👑 ZipDmone tapped! Royalty recognized.");
  }

  static void _onFlutterTap() {
    debugPrint("🪄 Flutter tapped! Magic enabled.");
  }
}
