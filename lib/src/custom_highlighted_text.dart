import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WordColorizer extends StatelessWidget {
  final String text;
  final Map<String, Color> highlightWordsWithColors;
  final Color? defaultColor;
  final TextAlign textAlign;
  final double fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final bool isHighlightClickable;
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
    this.fontWeight,
    this.fontStyle,
    this.isHighlightClickable = false,
    this.onHighlightTap,
    this.onHighlightTapMap,
  });

  @override
  Widget build(BuildContext context) {
    bool hasHighlightTap(String word) {
      return (onHighlightTap?.containsKey(word) ?? false) ||
          (onHighlightTap?.containsKey(word) ?? false);
    }

    VoidCallback? getHighlightTapCallback(String word) {
      return onHighlightTap?[word] ?? onHighlightTap?[word];
    }

    TextStyle resolveTextStyle(Color color, {bool isBold = false}) {
      final resolvedWeight = isBold ? FontWeight.bold : (fontWeight ?? FontWeight.normal);
      final resolvedStyle = fontStyle ?? FontStyle.normal;

      if (fontFamily != null && fontFamily!.toLowerCase().startsWith('google.')) {
        final googleFontName = fontFamily!.split('.').last;
        return _getGoogleFontTextStyle(
          googleFontName,
          color: color,
          size: fontSize,
          weight: resolvedWeight,
          style: resolvedStyle,
        );
      }

      return TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        color: color,
        fontWeight: resolvedWeight,
        fontStyle: resolvedStyle,
      );
    }

    List<InlineSpan> createTextSpans(String fullText, Map<String, Color> highlightMap) {
      List<InlineSpan> spans = [];
      int startIndex = 0;

      if (highlightMap.isEmpty) {
        spans.add(TextSpan(
          text: fullText,
          style: resolveTextStyle(defaultColor ?? Colors.black),
        ));
      } else {
        while (startIndex < fullText.length) {
          int earliestMatchIndex = fullText.length;
          String? matchedWord;

          for (final word in highlightMap.keys) {
            final matchIndex = fullText.indexOf(word, startIndex);
            if (matchIndex >= 0 && matchIndex < earliestMatchIndex) {
              earliestMatchIndex = matchIndex;
              matchedWord = word;
            }
          }

          if (matchedWord == null) {
            spans.add(TextSpan(
              text: fullText.substring(startIndex),
              style: resolveTextStyle(defaultColor ?? Colors.black),
            ));
            break;
          }

          if (earliestMatchIndex > startIndex) {
            spans.add(TextSpan(
              text: fullText.substring(startIndex, earliestMatchIndex),
              style: resolveTextStyle(defaultColor ?? Colors.black),
            ));
          }

          spans.add(TextSpan(
            text: matchedWord,
            style: resolveTextStyle(
              highlightWordsWithColors[matchedWord] ?? Colors.black,
              isBold: true,
            ),
            recognizer: isHighlightClickable && hasHighlightTap(matchedWord)
                ? (TapGestureRecognizer()..onTap = getHighlightTapCallback(matchedWord))
                : null,
          ));
          startIndex = earliestMatchIndex + matchedWord.length;
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

  TextStyle _getGoogleFontTextStyle(
    String fontName, {
    required Color color,
    required double size,
    FontWeight weight = FontWeight.normal,
    FontStyle style = FontStyle.normal,
  }) {
    try {
      return GoogleFonts.getFont(
        fontName,
        fontSize: size,
        fontWeight: weight,
        fontStyle: style,
        color: color,
      );
    } catch (_) {
      return TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight,
        fontStyle: style,
      );
    }
  }
}