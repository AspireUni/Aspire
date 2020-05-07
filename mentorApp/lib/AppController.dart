import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import "./Profile/UserProfile.dart";
import './Dashboard/Dashboard.dart';
import "./Chat/Chat.dart";

class AppController extends StatefulWidget {
    @override _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<AppController> {
    int pageIndex = 1; 
    double navBarIconSize = 30; 
    List<Widget> _widgets = [UserProfile(), Dashboard(), Chat()];

    tapped(int tappedIndex) {
        setState(() {pageIndex = tappedIndex;});
    }
    @override Widget build(BuildContext context) {
        return MaterialApp(
            home: Scaffold(
                body: _widgets[pageIndex],
                bottomNavigationBar: CurvedNavigationBar(
                backgroundColor: Colors.black, 
                index: 1,
                onTap: tapped,
                items: <Widget>[
                  Icon(Icons.person, size: navBarIconSize),
                  Icon(Icons.home, size: navBarIconSize),
                  Icon(Icons.chat_bubble, size: navBarIconSize),
                 ],
                 animationDuration: Duration(milliseconds: 200),
                 animationCurve: Curves.bounceInOut
             ), 
         ),
     );
   }
}
