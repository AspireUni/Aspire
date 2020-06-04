import 'package:flutter/material.dart';
import 'app_controller.dart';
import '../ftu/signup.dart';

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
        }
      );
    }
  }