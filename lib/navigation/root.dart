import 'package:aspire/FTU/rootpage.dart';
import 'package:flutter/material.dart';
import '../FTU/authentication.dart';
import '../FTU/rootpage.dart';
import 'app_controller.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Aspire',
        initialRoute: '/',
        routes: {
          '/': (context) => new RootPage(auth: new Auth()),
          '/AppController': (context) => AppController(),
        },
        theme: ThemeData(
          primaryColor: Color(0xFF0F1236),
          accentColor: Color(0xFF45cab9),
        )
      );
    }
  }