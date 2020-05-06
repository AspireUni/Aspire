import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MentorApp',
      home: MyHomePage(title: 'MentorApp'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black, 
        height: MediaQuery.of(context).size.height, 
        width: MediaQuery.of(context).size.width, 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: <Widget>[
            Text("Coming soon!",
              style: TextStyle(color: Colors.white, fontSize: 30.0)
            )
          ],
        ) 
      ), 
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.black, 
        buttonBackgroundColor: Colors.white,
        items: <Widget>[
          // TODO: Return the different screens/widgets here
          Icon(Icons.person, size: 30, color: Colors.black), 
          Icon(Icons.home, size: 30, color: Colors.black), 
          Icon(Icons.chat_bubble, size: 30, color:Colors.black)
        ], 
        animationDuration: Duration(
          milliseconds: 200
        ),
        animationCurve: Curves.bounceInOut,
        index: 1, // start at the home screen
        onTap: (index) {
          debugPrint("Current index is $index");
        }
      ),
    );
  }
}
