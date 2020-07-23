import '../models/models.dart';
import 'reducers.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    user: userReducer(state.user, action),
  );
}