import 'package:flutter/material.dart';

import '../ftu/filters.dart';
import '../ftu/signup.dart';
import 'app_controller.dart';


class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Aspire',
        initialRoute: '/',
        routes: {
          '/': (context) => FirstRoute(),
          '/filters': (context) => FiltersPage(),
          '/second': (context) => SecondRoute(),
          '/userprofile': (context) => AppController(),
        },
        theme: ThemeData(
          primaryColor: Color(0xFF0F1236),
          accentColor: Color(0xFF45cab9),
        )
      );
    }
  }