import 'package:flutter/material.dart';
import 'AppController.dart';
import '../FTU/SignUp.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MentorApp',
        initialRoute: '/',
        routes: {
          '/': (context) => FirstRoute(),
          '/second': (context) => SecondRoute(),
          '/UserProfile': (context) => AppController(),
        },
      );
    }
  }