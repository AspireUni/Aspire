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
        '/': (context) => RootPage(auth: Auth()),
        '/AppController': (context) => AppController(),
      }
    );
  }
}
