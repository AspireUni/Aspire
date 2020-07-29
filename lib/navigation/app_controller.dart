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


  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // void _openDrawer() {
  //   _scaffoldKey.currentState.openDrawer();
  // }

  // void _closeDrawer() {
  //   Navigator.of(context).pop();
  // }

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
        // key: _scaffoldKey,
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
        // drawer: Drawer(
        //   child: ListView(
        //     // Important: Remove any padding from the ListView.
        //     padding: EdgeInsets.zero,
        //     children: <Widget>[
        //       DrawerHeader(
        //         child: Text('Drawer Header'),
        //         decoration: BoxDecoration(
        //           color: Colors.blue,
        //         ),
        //       ),
        //       ListTile(
        //         title: Text('Item 1'),
        //         onTap: () {
        //           // Update the state of the app
        //           // ...
        //           // Then close the drawer
        //           Navigator.pop(context);
        //         },
        //       ),
        //       ListTile(
        //         title: Text('Item 2'),
        //         onTap: () {
        //           // Update the state of the app
        //           // ...
        //           // Then close the drawer
        //           Navigator.pop(context);
        //         },
        //       ),
        //       // RaisedButton(
        //       //     onPressed: _closeDrawer,
        //       //     child: const Text('Close Drawer'),
        //       //   ),
        //     ],
        //   ),
        // ),
        // // Disable opening the drawer with a swipe gesture.
        // drawerEnableOpenDragGesture: false,
      ); 
  }


  // buildControllerView(BuildContext context) {
  //   return (
  //     <Widget>[
  //       _screens[pageIndex],
  //       // Temporary until we get a drawer with the logout button
  //       buildDrawerButton(context)
  //     ]
  //   );
  // }

  // buildDrawerButton(BuildContext context){
  //   return ButtonTheme(
  //     padding: EdgeInsets.all(5.0),
  //     minWidth: 50.0,
  //     height: 20.0,
  //     child:RaisedButton(
  //       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //       onPressed: () =>  _openDrawer,
  //       color: Colors.red,
        
  //       child: Text(
  //         'Open Drawer',
  //         style: TextStyle(
  //           fontSize: 10,
  //           fontWeight: FontWeight.w700,
  //           color: Colors.white
  //         )
  //       ),
  //     )
  //   );
  // }

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
