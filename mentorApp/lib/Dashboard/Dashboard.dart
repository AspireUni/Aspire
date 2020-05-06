import 'package:flutter/material.dart';

// TODO: Update this placeholder widget
class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context, index) {
        return ListTile(
          title: Text('Dashboard'),
          subtitle: Text('$index'),
        );
      }),
    );
  }
}