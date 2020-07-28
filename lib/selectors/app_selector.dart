import 'package:redux/redux.dart';

import '../models/models.dart';

AppState appStateSelector(Store<AppState> store) {
  return store.state;
}