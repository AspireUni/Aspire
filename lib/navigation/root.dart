import 'package:flutter/material.dart';

import '../FTU/authentication.dart';
import '../FTU/rootpage.dart';
import 'app_controller.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Aspire',
        initialRoute: '/',
        routes: {
          '/': (context) => RootPage(auth: Auth()),
          '/AppController': (context) => AppController(),
        },
        theme: ThemeData(
          primaryColor: Color(0xFF0F1236),
          accentColor: Color(0xFF45cab9),
        )
      )
    );
  }
}
