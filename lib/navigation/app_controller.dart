import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
//import '../FTU/authentication.dart';

import '../chat/chat.dart';
import '../constants/app_controller_constants.dart';
import '../pairings/pairings.dart';
import '../profile/view_profile/user_profile.dart';


class AppController extends StatefulWidget {
  // AppController({Key key, this.auth, this.userId, this.logoutCallback})
  //     : super(key: key);

  // final BaseAuth auth;
  // final VoidCallback logoutCallback;
  // final String userId;
  
  final int tabIndex;
  AppController({Key key, this.tabIndex}) : super(key: key);

  @override

  State<StatefulWidget> createState() => _AppControllerState();
}

class _AppControllerState extends State<AppController> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final List<Widget> _screens = [UserProfile(), Pairings(), Chat()];
  int pageIndex; 
  double navBarIconSize = 25.0; 

  @override
  void initState() {
    super.initState();

    pageIndex = widget.tabIndex ?? 1;
  }

  void tapNavItem(int tappedIndex) {
    setState(() { pageIndex = tappedIndex; });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
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
      ); 
  }

  // signOut() async {
  //   try {
  //     await widget.auth.signOut();
  //     widget.logoutCallback();
  //   } on Exception catch (e) {
  //     print(e);

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
