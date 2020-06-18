// import 'package:device_preview/device_preview.dart';
// import 'package:flutter/material.dart';
// import "./navigation/root.dart";
// void main() => {
//   runApp(
//     DevicePreview(
//       enabled: true,
//       areSettingsEnabled: true,  
//       builder: (context) => App()
//     )
//   )
// }; 

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       builder: DevicePreview.appBuilder,
//       home: Root()
//     );
//   }
// }

import 'package:flutter/material.dart';
import './FTU/authentication.dart';
import './FTU/rootpage.dart';

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
        home: new RootPage(auth: new Auth()));
  }
}
