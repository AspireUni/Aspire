import 'package:flutter/material.dart';
import "./navigation/root.dart";
void main() {
  runApp(new App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Welcome to Aspire',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Root());
        //home: new RootPage(auth: new Auth()));
  }
}
