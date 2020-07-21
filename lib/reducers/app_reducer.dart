import '../models/models.dart';
import 'user_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    user: userReducer(state.user, action),
  );
}