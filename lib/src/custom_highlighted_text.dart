import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WordColorizer extends StatelessWidget {
  final String text;
  final Map<String, Color> highlightWordsWithColors;
  final Color? defaultColor;

  final TextAlign textAlign;
  final double fontSize;
  final bool isHighlightClickable;
  final Map<String, VoidCallback>? onHighlightTapMap;

  const WordColorizer({
    super.key,
    required this.text,
    this.highlightWordsWithColors = const {},
    this.defaultColor,
    this.textAlign = TextAlign.center,
    this.fontSize = 24,
    this.isHighlightClickable = false,
    this.onHighlightTapMap,
  });

  @override
  Widget build(BuildContext context) {
    List<InlineSpan> createTextSpans(String fullText, Map<String, Color> highlightMap) {
      List<InlineSpan> spans = [];
      int startIndex = 0;

      TextStyle defaultTextStyle() {
        return TextStyle(
          fontSize: fontSize,
          color: defaultColor ?? Colors.black,
        );
      }

      if (highlightMap.isEmpty) {
        spans.add(TextSpan(
          text: fullText,
          style: defaultTextStyle(),
        ));
      } else {
        for (final entry in highlightMap.entries) {
          final String word = entry.key;
          final Color color = entry.value;

          int matchIndex = fullText.indexOf(word, startIndex);
          if (matchIndex == -1) continue; // Skip if the word is not found.
          if (matchIndex > startIndex) {
            spans.add(
              TextSpan(
                text: fullText.substring(startIndex, matchIndex),
                style: defaultTextStyle(),
              ),
            );
          }
          spans.add(
            TextSpan(
              text: word,
              style: TextStyle(
                fontSize: fontSize,
                color: color,
                fontWeight: FontWeight.bold,
              ),
              recognizer: isHighlightClickable &&
                      onHighlightTapMap != null &&
                      onHighlightTapMap!.containsKey(word)
                  ? (TapGestureRecognizer()..onTap = onHighlightTapMap![word])
                  : null,
            ),
          );
          startIndex = matchIndex + word.length;
        }
        if (startIndex < fullText.length) {
          spans.add(
            TextSpan(
              text: fullText.substring(startIndex),
              style: defaultTextStyle(),
            ),
          );
        }
      }

      return spans;
    }

    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        children: createTextSpans(text, highlightWordsWithColors),
      ),
    );
  }
}
