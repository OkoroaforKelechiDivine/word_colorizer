# WordColorizer

`WordColorizer` is a powerful and customizable Flutter widget that allows you to highlight specific words in a given text. It also supports interactivity, enabling you to add clickable actions for highlighted words such as navigation, callbacks, or other custom behaviors. This widget is ideal for use in chat applications, educational apps, blogs, or any app that needs to highlight and interact with specific words.

---

## Features

- **Highlight Words**: Specify words within the text that should be highlighted.
- **Customizable Styles**: Easily customize the highlight color, default color, font size, and text alignment.
- **Interactive Highlights**: Make highlighted words clickable and define custom actions (such as navigating to a different screen).
- **Supports Multiple Words**: Highlight multiple words in the same text and apply different actions to each.
- **No Dependencies**: This package is lightweight and doesn't rely on third-party libraries for font styling.

---



## Installation

Add the package to your `pubspec.yaml` file:

```yaml
dependencies:
  word_colorizer: ^1.0.0

```

## Run

```console
flutter pub get

```
---

## 🎬 Demo Video

Check out the video below to see **Project Name** in action:  

(./lib/src/video.gif)  

---

## Usage for multiple words

```dart

import 'package:flutter/material.dart';
import 'package:word_colorizer/word_colorizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Word Colorizer Example')),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: WordColorizer(
            text: "By selecting Agree and continue, I agree to Dynamic Layers Terms of Service, Payments Terms of Service and Notification Policy and acknowledge the Privacy Policy.",
            highlightWords: "Terms of Service, Payments Terms of Service, Notification Policy, Privacy Policy",
            fontSize: 11,
            textAlign: TextAlign.left,
            highlightColor: Colors.blue,
            isHighlightClickable: true,
            onHighlightTapMap: {
              "Terms of Service": () {
                print("Terms of Service clicked");
              },
              "Payments Terms of Service": () {
                print("Payments Terms of Service clicked");
              },
              "Notification Policy": () {
                print("Notification Policy clicked");
              },
              "Privacy Policy": () {
                print("Privacy Policy clicked");
              },
            },
          ),
        ),
      ),
    );
  }
}

```
