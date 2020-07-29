import 'package:redux/redux.dart';

import '../constants/common_constants.dart';
import '../models/models.dart';

UserState userStateSelector(Store<AppState> store) {
  return store.state.userState;
}

UserType userTypeSelector(Store<AppState> store) {
  return store.state.userState.type;
}

AuthStatus authStatusSelector(Store<AppState> store) {
  return store.state.userState.authStatus;
}

bool isFtuSelector(Store<AppState> store) {
  return store.state.userState.isFtu;
}