import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import "./navigation/root.dart";
void main() => {
  runApp(
    DevicePreview(
      enabled: true,
      areSettingsEnabled: true,  
      builder: (context) => App()
    )
  )
}; 

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      home: Root()
    );
  }
}

