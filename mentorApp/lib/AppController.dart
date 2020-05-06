import 'package:flutter/material.dart';
import "./Profile/UserProfile.dart";
import './Dashboard/Dashboard.dart';
import "./Chat/Chat.dart";

class AppController extends StatefulWidget {
    @override _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<AppController> {
    int index = 0;
    List<Widget> _widgets = [UserProfile(), Dashboard(), Chat()];
    tapped(int tappedIndex) {
        setState(() {index = tappedIndex;});
    }
    @override Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                body: _widgets[index],
                bottomNavigationBar: BottomNavigationBar(
                currentIndex: index,
                onTap: tapped,
                items: [
                    BottomNavigationBarItem(icon: new Icon(Icons.person), title: Text('Profile')),
                    BottomNavigationBarItem(icon: new Icon(Icons.home), title: Text('Home')),
                    BottomNavigationBarItem(icon: new Icon(Icons.chat_bubble), title: Text('Chat')),
                 ],
             ),
         ),
     );
   }
}
