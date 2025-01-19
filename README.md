# WordColorizer

`WordColorizer` is a powerful and customizable Flutter widget that allows you to highlight specific words in a given text. It also supports interactivity, enabling you to add clickable actions for highlighted words such as navigation, callbacks, or other custom behaviors. This widget is ideal for use in chat applications, educational apps, blogs, or any app that needs to highlight and interact with specific words.

---

## Features

- **Highlight Words**: Specify words within the text that should be highlighted.
- **Customizable Styles**: Easily customize the highlight color, default color, font size, font family and text alignment.
- **Interactive Highlights**: Make highlighted words clickable and define custom actions (such as navigating to a different screen).
- **Supports Multiple Words**: Highlight multiple words in the same text and apply different actions to each.
- **No Dependencies**: This package is lightweight and doesn't rely on third-party libraries for font styling.

---


## Installation

Add the package to your `pubspec.yaml` file:

```yaml
dependencies:
  word_colorizer: ^0.0.5

```

## Run

```console
flutter pub get

```

---

https://github.com/user-attachments/assets/10a9fde9-a1a4-4b0a-95cb-4804f24e06f7

---

## Usage 

```dart
import 'package:flutter/material.dart';
import 'package:word_colorizer/word_colorizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text("Word Colorization")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: WordColorizer(
          text: "The is Kelechi Divine's project",
          highlightWordsWithColors: const {
            "Kelechi" : Colors.green,
            "project" : Colors.yellow,
          },
          fontFamily: "Roboto",
          onHighlightTap: {
            "Kelechi":() => print("Do the navigation here"),
            "project" : () => print("Do the navigation here")
          },
        ),
      ),
    ),
    );
  }
}
```