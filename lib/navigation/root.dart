import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../actions/actions.dart';
import '../common/common.dart';
import '../constants/common_constants.dart';
import '../ftu/onboarding/intro.dart';
import '../models/models.dart';
import '../profile/save_profile/save_profile.dart';
import '../selectors/selectors.dart';
import '../services/services.dart';
import 'app_controller.dart';

class Root extends StatefulWidget {
  Root({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RootState();
}

class _RootState extends State<Root>{
  final GlobalKey<FormBuilderState> _buildProfileKey
    = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    getCurrentUser(StoreProvider.of<AppState>(context, listen: false));
  }
 
  void getCurrentUser(Store<AppState> store) async {
    getCurrentAuthUser().then((user) async {
      var userData = await getUser(user?.uid);
      store.dispatch(ConvertToUserState(userData));
    });
  }

  Widget getNextPage(AppState state) {
    switch (state.userState.authStatus) {
      case AuthStatus.notDetermined:
        return loadingScreen;
      case AuthStatus.notLoggedIn:
        return OnboardingIntro();
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
    CommonContext().init(context); 

    return CustomSplash(
      imagePath: 'images/splash_screen_icon.png', 
      backGroundColor: Color(0xFF0A0B33),
      home: StoreConnector<AppState, AppState>(
        converter: appStateSelector,
        builder: (context, state) => getNextPage(state)
      ),
      duration: 3000, 
      type: CustomSplashType.StaticDuration
    );  
  }
}
