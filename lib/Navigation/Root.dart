import 'package:flutter/material.dart';
import 'AppController.dart';
import '../FTU/SignUp.dart';
import 'package:mentorApp/FTU/Filters.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MentorApp',
        initialRoute: '/',
        routes: {
          '/': (context) => FirstRoute(),
          '/second': (context) => SecondRoute(),
          '/completion': (context) => MyStatefulWidget(),
          '/UserProfile': (context) => AppController(),
        },
      );
    }
  }