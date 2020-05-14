import 'package:device_simulator/device_simulator.dart';
import 'package:flutter/material.dart';
import "./navigation/root.dart";

const bool debugEnableDeviceSimulator = true;
void main() => runApp(App()); 

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final app = debugEnableDeviceSimulator ? 
      MaterialApp(
        home: DeviceSimulator(
          brightness: Brightness.dark, 
          enable: debugEnableDeviceSimulator, 
          child: Root()
        )
      ) 
    : 
      Root();

    return app;
  }
}
