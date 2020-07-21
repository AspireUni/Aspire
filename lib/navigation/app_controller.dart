import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../FTU/authentication.dart';
import '../actions/actions.dart';
import '../chat/chat.dart';
import '../constants/navigation_constants.dart';
import '../models/models.dart';
import '../pairings/pairings.dart';
import '../profile/view_profile/user_profile.dart';


class AppController extends StatefulWidget {
  AppController({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => _AppControllerState();
}

class _AppControllerState extends State<AppController> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int pageIndex = 1; 
  double navBarIconSize = 30; 
  final List<Widget> _widgets = [UserProfile(), Pairings(), Chat()];

  tapped(int tappedIndex) {
    setState(() {pageIndex = tappedIndex;});
  }
  @override Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _widgets[pageIndex],
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          height: appNavBarHeight,  
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
      theme: ThemeData(
        primaryColor: Color(0xFF0F1236),
        accentColor: Color(0xFF45cab9),
      )
    ); 
  }
  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
      StoreProvider.of<AppState>(context).dispatch(
        UpdateUser(User.initial()));
    } on Exception catch (e) {
      print(e);
    }
  }
}
