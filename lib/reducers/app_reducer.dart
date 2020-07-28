import '../actions/actions.dart';

import '../models/models.dart';
import 'reducers.dart';

AppState appReducer(AppState state, action) {
  if (action is UpdateAppState) {
    return action.payload;
  }
  return AppState(
    userState: userReducer(state.userState, action),
  );
}

