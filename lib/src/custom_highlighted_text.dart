import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
 
/// This widget allows you to specify words within the text to be highlighted
/// with a distinct color and optional interactivity.
/// 
/// Example usage:
/// ```dart
/// WordColorizer(
///   text: "Flutter is an amazing framework.",
///   highlightWords: "Flutter,framework",
///   highlightColor: Colors.blue,
///   defaultColor: Colors.black,
///   isHighlightClickable: true,
///   onHighlightTapMap: {
///     "Flutter": () => print("Flutter tapped"),
///   },
/// )
/// ```
/// 
class WordColorizer extends StatelessWidget {
  final String text;
  final String highlightWords;
  final Color? highlightColor;
  final Color? defaultColor;

  final TextAlign textAlign;
  final double fontSize;
  final bool isHighlightClickable;
  final Map<String, VoidCallback>? onHighlightTapMap;

  const WordColorizer({
    super.key,
    required this.text,
    required this.highlightWords,
    this.highlightColor,
    this.defaultColor,
    this.textAlign = TextAlign.center,
    this.fontSize = 24,
    this.isHighlightClickable = false,
    this.onHighlightTapMap,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> highlightList = highlightWords.split(',').map((e) => e.trim()).toList();

    List<InlineSpan> createTextSpans(String fullText, List<String> highlightList) {
      List<InlineSpan> spans = [];
      int startIndex = 0;

      TextStyle defaultTextStyle() {
        return TextStyle(
          fontSize: fontSize,
          color: defaultColor ?? Colors.black,
        );
      }

      TextStyle highlightTextStyle() {
        return TextStyle(
          fontSize: fontSize,
          color: highlightColor ?? Colors.green,
          fontWeight: FontWeight.bold,
        );
      }

      for (final word in highlightList) {
        final int matchIndex = fullText.indexOf(word, startIndex);
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
            style: highlightTextStyle(),
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

      return spans;
    }

    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        children: createTextSpans(text, highlightList),
      ),
    );
  }
}
