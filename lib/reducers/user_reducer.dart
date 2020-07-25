import 'package:redux/redux.dart';

import '../actions/actions.dart';
import '../models/models.dart';
import 'reducers.dart';

final userReducer = TypedReducer<UserState, dynamic>(_userReducer);

UserState _userReducer(UserState userState, dynamic action) {
  if (action is UpdateUserState) {
    return action.payload;
  }
  if (action is ConvertToUserState) {
    var user = User.fromJson(action.payload);
    return UserState.initial().copyWith(
      id: user.id,
      isFtu: user.isFtu,
      saveProfileState: SaveProfileState.initial().copyWith(
        contact: Contact.initial().copyWith(
          emailAddress: user.contact.emailAddress
        )
      )
    );
  }
  if (action is UpdateAuthStatus) {
    return userState.copyWith(
      authStatus: action.payload
    );
  }
  if (action is UpdateIsFtu) {
    return userState.copyWith(
      isFtu: action.payload
    );
  }

  return userState.copyWith(
    saveProfileState: saveProfileStateReducer(
      userState.saveProfileState, action
    )
  );
}