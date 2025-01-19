import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WordColorizer extends StatelessWidget {
  final String text;
  final Map<String, Color> highlightWordsWithColors;
  final Color? defaultColor;

  final TextAlign textAlign;
  final double fontSize;
  final String? fontFamily;
  final bool isHighlightClickable;
  /// New property to replace `onHighlightTapMap`.
  final Map<String, VoidCallback>? onHighlightTap;

  @Deprecated('Use `onHighlightTap` instead.')
  final Map<String, VoidCallback>? onHighlightTapMap;

  const WordColorizer({
    super.key,
    required this.text,
    this.highlightWordsWithColors = const {},
    this.defaultColor,
    this.textAlign = TextAlign.center,
    this.fontSize = 24,
    this.fontFamily,
    this.isHighlightClickable = false,
    this.onHighlightTap,
    this.onHighlightTapMap,
  });

  @override
  Widget build(BuildContext context) {
    bool hasHighlightTap(String word) {
      return (onHighlightTap?.containsKey(word) ?? false) ||
          (onHighlightTapMap?.containsKey(word) ?? false);
    }

    VoidCallback? getHighlightTapCallback(String word) {
      return onHighlightTap?[word] ?? onHighlightTapMap?[word];
    }

    List<InlineSpan> createTextSpans(String fullText, Map<String, Color> highlightMap) {
      List<InlineSpan> spans = [];
      int startIndex = 0;

      TextStyle defaultTextStyle() {
        return TextStyle(
          fontSize: fontSize,
          fontFamily: fontFamily,
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
                fontFamily: fontFamily,
                color: color,
                fontWeight: FontWeight.bold,
              ),
              recognizer: isHighlightClickable && hasHighlightTap(word)
                  ? (TapGestureRecognizer()..onTap = getHighlightTapCallback(word))
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