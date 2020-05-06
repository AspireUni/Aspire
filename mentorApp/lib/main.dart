import 'package:flutter/material.dart';
import 'AppController.dart';

void main() => runApp(App()); 

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MentorApp',
      home: AppController()
    );
  }
}

