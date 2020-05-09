import 'package:flutter/material.dart';
import 'FTU/SignUp.dart';
import 'Funnel/Funnel.dart';
import 'AppController.dart';

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
      '/funnel': (context) => Funnel(),
      '/UserProfile': (context) => AppController(),
      },
    );
  }
}

