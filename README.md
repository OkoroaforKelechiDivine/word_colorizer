# WordColorizer

The `WordColorizer` Flutter package allows developers to enhance text by highlighting specific words with customizable styles and interactive features, particularly useful in applications like chat and educational tools. It supports multiple highlighted words, each with customizable actions, without relying on external libraries, making it lightweight and efficient. The package's flexibility in styling and interactivity empowers developers to create rich application user experiences.

---

## Features

- WordColorizer enables the customization of text by highlighting specific words.
- Users can define the highlight colour, font size, font family, and text alignment.
- Highlighted words can be made interactive, allowing clickable actions such as navigation.
- The widget supports the highlighting of multiple words within the same text, each with different actions.
- The package is lightweight and does not depend on third-party libraries for font styling.


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
