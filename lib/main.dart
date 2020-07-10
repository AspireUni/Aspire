import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import './constants/signuplogin_constants.dart';
import './navigation/root.dart';

bool enableDevicePreview = false;

void main() => {
  runApp(
    DevicePreview(
      enabled: enableDevicePreview,
      areSettingsEnabled: true,  
      builder: (context) => App()
    )
  )
}; 

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: welcomeMessage,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Root());
  }
}
