import 'package:device_simulator/device_simulator.dart';
import 'package:flutter/material.dart';
import 'FTU/SignUp.dart';
import 'AppController.dart';

const bool debugEnableDeviceSimulator = false;

void main() => runApp(App()); 

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final app = debugEnableDeviceSimulator ? 
      MaterialApp(
        home: DeviceSimulator(
          brightness: Brightness.dark, 
          enable: debugEnableDeviceSimulator, 
          child: MaterialApp(title: 'MentorApp',
            initialRoute: '/',
            routes: {
              '/': (context) => FirstRoute(),
              '/second': (context) => SecondRoute(),
              '/UserProfile': (context) => AppController(),
            }
          )
        )
      ) 
    :
      MaterialApp(
        title: 'MentorApp',
        initialRoute: '/',
        routes: {
          '/': (context) => FirstRoute(),
          '/second': (context) => SecondRoute(),
          '/UserProfile': (context) => AppController(),
        },
      );
    return app;
  }
}

