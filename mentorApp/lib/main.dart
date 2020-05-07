import 'package:flutter/material.dart';
import 'SignUp/FTU.dart';
import 'AppController.dart';
import 'Profile/UserProfile.dart';

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
      '/UserProfile': (context) => AppController(),
      },
    );
  }
}

