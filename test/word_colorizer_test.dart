import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:word_colorizer/word_colorizer.dart';

void main() {
  group('WordColorizer Tests', () {
    testWidgets(
        'should display text without highlighting when no highlight words provided',
        (WidgetTester tester) async {
      const String text = 'Flutter is amazing';

      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: WordColorizer(
            text: text,
            highlightWordsWithColors: {},
            defaultColor: Colors.black,
          ),
        ),
      ));

      expect(find.text('Flutter is amazing'), findsOneWidget);
      final richTextWidget = tester.widget<RichText>(find.byType(RichText));
      final spans = (richTextWidget.text as TextSpan).children!;
      for (var span in spans) {
        expect((span as TextSpan).style?.color, Colors.black);
      }
    });

    testWidgets('should highlight specified words with correct colors',
        (WidgetTester tester) async {
      const String text = 'Flutter is an amazing framework';
      final highlightWordsWithColors = {
        'Flutter': Colors.blue,
        'framework': Colors.red,
      };

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: WordColorizer(
            text: text,
            highlightWordsWithColors: highlightWordsWithColors,
            defaultColor: Colors.black,
          ),
        ),
      ));

      final richTextWidget = tester.widget<RichText>(find.byType(RichText));
      final spans = (richTextWidget.text as TextSpan).children!;
      for (var span in spans) {
        final text = (span as TextSpan).text;
        final expectedColor = highlightWordsWithColors[text] ?? Colors.black;
        expect(span.style?.color, expectedColor);
      }
    });

    testWidgets('should handle clickable highlighted words',
        (WidgetTester tester) async {
      const String text = 'Flutter is an amazing framework';
      final highlightWordsWithColors = {
        'Flutter': Colors.blue,
        'framework': Colors.red,
      };
      bool tappedFlutter = false;
      bool tappedFramework = false;

      final onTapMap = {
        'Flutter': () => tappedFlutter = true,
        'framework': () => tappedFramework = true,
      };

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: WordColorizer(
            text: text,
            highlightWordsWithColors: highlightWordsWithColors,
            defaultColor: Colors.black,
            isHighlightClickable: true,
            onHighlightTapMap: onTapMap,
          ),
        ),
      ));

      await tester.tap(find.text('Flutter'));
      await tester.tap(find.text('framework'));

      expect(tappedFlutter, true);
      expect(tappedFramework, true);
    });

    testWidgets(
        'should handle highlighting multiple words with different colors',
        (WidgetTester tester) async {
      const String text = 'Flutter is an amazing framework';
      final highlightWordsWithColors = {
        'Flutter': Colors.green,
        'amazing': Colors.purple,
        'framework': Colors.orange,
      };

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: WordColorizer(
            text: text,
            highlightWordsWithColors: highlightWordsWithColors,
            defaultColor: Colors.black,
          ),
        ),
      ));

      final richTextWidget = tester.widget<RichText>(find.byType(RichText));
      final spans = (richTextWidget.text as TextSpan).children!;

      for (var span in spans) {
        final text = (span as TextSpan).text;
        final expectedColor = highlightWordsWithColors[text] ?? Colors.black;
        expect(span.style?.color, expectedColor);
      }
    });
  });
}
