import 'package:flutter/material.dart';
import 'FTU/SignUp.dart';
import 'AppController.dart';
import 'FTU/Filters/DropDownPage.dart';
import 'FTU/Completion.dart';

void main() => runApp(App()); 

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MentorApp',
      //home: AppController(),
      initialRoute: '/',
      routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => FirstRoute(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/second': (context) => SecondRoute(),
      '/filters': (context) => DropDownPage(),
      '/completion': (context) => Completed(),
      '/profiles': (context) => AppController(),
      },
    );
  }
}

