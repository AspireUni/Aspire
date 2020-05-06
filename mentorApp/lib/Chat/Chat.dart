import 'package:flutter/material.dart';

// TODO: Update this placeholder widget
class Chat extends StatelessWidget {
  const Chat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context, index) {
        return ListTile(
          title: Text('Chat message'),
          subtitle: Text('$index'),
        );
      }),
    );
  }
}