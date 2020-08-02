import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../chat/chat.dart';
import '../constants/app_controller_constants.dart';
import '../models/states/states.dart';
import '../pairings/pairings.dart';
import '../profile/view_profile/user_profile.dart';
import '../selectors/selectors.dart';


class AppController extends StatefulWidget {
  final int tabIndex;
  AppController({Key key, this.tabIndex}) : super(key: key);

  @override

  State<StatefulWidget> createState() => _AppControllerState();
}

class _AppControllerState extends State<AppController> {

  Store<AppState> store;
  String uid;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<Widget> _screens;
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
    store = StoreProvider.of<AppState>(context);
    uid = userIdSelector(store);
    _screens = [UserProfile(profileId: uid), Pairings(), Chat()];
    return Scaffold(
        body: 
        _screens[pageIndex],
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
        ),
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
