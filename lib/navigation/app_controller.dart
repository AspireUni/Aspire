import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../FTU/authentication.dart';
import '../chat/chat.dart';
import '../constants/app_controller_constants.dart';
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
  final List<Widget> _screens = [UserProfile(), Pairings(), Chat()];
  int pageIndex = 1; 
  double navBarIconSize = 25.0; 

  void tapNavItem(int tappedIndex) {
    setState(() { pageIndex = tappedIndex; });
  }

  void signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } on Exception catch (e) {
      print(e);
    }
  }

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _screens[pageIndex],
        bottomNavigationBar: CustomNavigationBar(
          elevation: 0.0,
          onTap: tapNavItem,
          items: buildNavItems(),
          currentIndex: pageIndex,
          iconSize: navBarIconSize,
          selectedColor: navItemColor,
          strokeColor: navItemColor, 
          unSelectedColor: Colors.grey,
          backgroundColor: Colors.white,
        )
      )
    ); 
  }

  List<CustomNavigationBarItem> buildNavItems() {
    var navItems = <CustomNavigationBarItem>[];
    for( var i = 0; i < navItemIcons.length; i++ ) { 
      navItems.add(
        CustomNavigationBarItem(
          icon: navItemIcons[i]
        )
      );
    }
    return navItems;
   } 
}
