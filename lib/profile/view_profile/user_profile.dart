import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../actions/actions.dart';
import '../../constants/common_constants.dart';
import '../../models/models.dart';
import '../../selectors/selectors.dart';
import '../../services/services.dart';
import './header.dart';
import './sections/sections.dart';
 
class UserProfile extends StatefulWidget {
  final String profileId;
  final String matchId;
  const UserProfile(
    {Key key, @required this.profileId, this.matchId}
  ) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  Store<AppState> store;
  String uid;

  @override
  Widget build(BuildContext context) {
    store = StoreProvider.of<AppState>(context);
    uid = userIdSelector(store);
    var viewOnly = uid == widget.profileId;

    return FutureBuilder(
      future: getUser(widget.profileId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingScreen;
        } else {
          var user = User.fromJson(snapshot.data);
          return Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              margin: EdgeInsets.all(0),
              child: Center(
                child: Column(
                  children: buildUserProfileView(
                    context, 
                    user, 
                    viewOnly: viewOnly
                  )
                )
              )
            )
          );
        }
      }
    );
  }

  buildUserProfileView(BuildContext context, User user, {bool viewOnly}) {
    return (
      <Widget>[
        ProfileHeader(fullName: user.fullName, viewOnly: viewOnly),
        ProfileSections(
          user: user, 
          viewOnly: viewOnly, 
          matchId: widget.matchId
        ),
        // Temporary until we get a drawer with the logout button
        if(viewOnly) buildLogoutButton(context)
      ]
    );
  }

  // Temporary until we get a drawer with the logout button
  buildLogoutButton(BuildContext context){
    return ButtonTheme(
      padding: EdgeInsets.all(5.0),
      minWidth: 50.0,
      height: 20.0,
      child:RaisedButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () => logout(context),
        color: Colors.red,
        child: Text(
          'LOGOUT',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: Colors.white
          )
        ),
      )
    );
  }

  void logout(BuildContext context) async {
    try {
      await authSignOut();
      StoreProvider.of<AppState>(context).dispatch(
        UpdateUserState(UserState.initial().copyWith(
          authStatus: AuthStatus.notLoggedIn
        ))
      );
      Navigator.pushNamedAndRemoveUntil(context,
        '/',
        (route) => false
      );
    } on Exception catch (e) {
      print(e);
    }
  }

}