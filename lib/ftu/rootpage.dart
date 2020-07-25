import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../Navigation/app_controller.dart';
import '../actions/actions.dart';
import '../constants/common_constants.dart';
import '../models/models.dart';
import '../profile/save_profile/save_profile.dart';
import '../selectors/selectors.dart';
import '../services/user_service.dart';
import './authentication.dart';
import './signuplogin.dart';

class RootPage extends StatefulWidget {
  RootPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>{
  final GlobalKey<FormBuilderState> _buildProfileKey
    = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    getCurrentUser(StoreProvider.of<AppState>(context, listen: false));
  }
 
  void getCurrentUser(Store<AppState> store) async {
    Auth().getCurrentUser().then((user) async {
      var userData = await getUser(user?.uid);
      if (userData != null){
        store.dispatch(ConvertToUserState(userData));
      }
      store.dispatch(
        UpdateAuthStatus(
          userData == null ? AuthStatus.notLoggedIn : AuthStatus.loggedIn
        )
      );
    });
  }

  Widget getNextPage(AppState state) {
    switch (state.userState.authStatus) {
      case AuthStatus.notDetermined:
        return loadingScreen;
      case AuthStatus.notLoggedIn:
        return LoginSignupPage();
      case AuthStatus.loggedIn:
        if (state.userState.isFtu) {
          return SaveProfile(
            editMode: false,
            formKey: _buildProfileKey
          );
        }
        return AppController();
      default:
        return loadingScreen;
    }
      
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: appStateSelector,
      builder: (context, state) => getNextPage(state)
    );
  }
}
