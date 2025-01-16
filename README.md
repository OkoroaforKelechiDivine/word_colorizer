# CustomHighlightedText Flutter Package

`CustomHighlightedText` is a Flutter widget that allows you to highlight specific words within a given text, with support for multiple words. The highlighted words can be made interactive, and you can associate different actions (such as navigation) for each highlighted word.

### Features:
- **Highlight single or multiple words** within the text.
- **Customizable highlight color** for highlighted words.
- **Customizable text color** for non-highlighted text.
- **Clickable highlighted words** with customizable actions for navigation or other tasks.
- **Supports both iOS and Android**.

---

## Installation

Add the `CustomHighlightedText` package to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  custom_highlighted_text: ^1.0.0


## Usage

### Basic Usage:

To use the `CustomHighlightedText` widget, simply pass in the full text and the words you want to highlight.

```dart
import 'package:flutter/material.dart';
import 'package:custom_highlighted_text/custom_highlighted_text.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Custom Highlighted Text Example"),
        ),
        body: Center(
          child: CustomHighlightedText(
            text: "Flutter is an amazing framework.",
            highlightWords: "Flutter,framework",
            highlightColor: Colors.blue,
            defaultColor: Colors.black,
            isHighlightClickable: true,
            onHighlightTapMap: {
              "Flutter": () => print("Flutter tapped"),
              "framework": () => print("framework tapped"),
            },
          ),
        ),
      ),
    );
  }
}
# word_colorizer
