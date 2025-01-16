import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:word_colorizer/word_colorizer.dart';

void main() {
  group('CustomHighlightedText Tests', () {
    testWidgets('should display text without highlighting when no highlight words provided', (WidgetTester tester) async {
      const String text = 'Flutter is amazing';
      const String highlightWords = '';

      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: WordColorizer(
            text: text,
            highlightWords: highlightWords,
            highlightColor: Colors.blue,
            defaultColor: Colors.black,
          ),
        ),
      ));

      expect(find.text('Flutter is amazing'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.text('Flutter is amazing'));
      expect(textWidget.style?.color, Colors.black);
    });

    testWidgets('should highlight specified words', (WidgetTester tester) async {
      const String text = 'Flutter is an amazing framework';
      const String highlightWords = 'Flutter,framework';

      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: WordColorizer(
            text: text,
            highlightWords: highlightWords,
            highlightColor: Colors.blue,
            defaultColor: Colors.black,
          ),
        ),
      ));

      expect(find.text('Flutter'), findsOneWidget);
      expect(find.text('framework'), findsOneWidget);

      final flutterTextWidget = tester.widget<Text>(find.text('Flutter'));
      final frameworkTextWidget = tester.widget<Text>(find.text('framework'));

      expect(flutterTextWidget.style?.color, Colors.blue);
      expect(frameworkTextWidget.style?.color, Colors.blue);

      expect(find.text('is'), findsOneWidget);
      final isTextWidget = tester.widget<Text>(find.text('is'));
      expect(isTextWidget.style?.color, Colors.black);
    });

    testWidgets('should handle clickable highlighted words', (WidgetTester tester) async {
      const String text = 'Flutter is an amazing framework';
      const String highlightWords = 'Flutter,framework';
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
            highlightWords: highlightWords,
            highlightColor: Colors.blue,
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

    testWidgets('should handle highlighting multiple words and navigate correctly', (WidgetTester tester) async {
      const String text = 'Flutter is an amazing framework';
      const String highlightWords = 'Flutter,framework';
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
            highlightWords: highlightWords,
            highlightColor: Colors.blue,
            defaultColor: Colors.black,
            isHighlightClickable: true,
            onHighlightTapMap: onTapMap,
          ),
        ),
      ));

      // Simulate tapping the highlighted words
      await tester.tap(find.text('Flutter'));
      await tester.tap(find.text('framework'));

      // Assert: Ensure the callbacks for multiple words are triggered
      expect(tappedFlutter, true);
      expect(tappedFramework, true);
    });
  });
}
