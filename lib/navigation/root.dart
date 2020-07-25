import 'package:flutter/material.dart';

import '../FTU/rootpage.dart';
import 'app_controller.dart';

class Root extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aspire',
      initialRoute: '/',
      routes: {
        '/': (context) => RootPage(),
        '/AppController': (context) => AppController()
      },
      // Temporary until profile and chat views are modified
      // to look like the new mockups
      theme: ThemeData(	
        primaryColor: Color(0xFF0F1236),	
        accentColor: Color(0xFF45cab9),	
      )
    );
  }
}
