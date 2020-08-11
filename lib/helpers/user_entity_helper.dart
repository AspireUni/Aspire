import 'package:redux/redux.dart';

import '../models/models.dart';
import '../selectors/selectors.dart';
import '../services/services.dart';

dynamic convertProfileStateToUserEntity(Store<AppState> store) async {
  var userState = userStateSelector(store);
  var saveProfileState = saveProfileStateSelector(store);
  var user = User.fromJson(await getUser(userState.id));

  return user.copyWith(
    id: userState.id,
    isFtu: userState.isFtu,
    fullName: saveProfileState.fullName,
    emailAddress: saveProfileState.emailAddress,
    phoneNumber: saveProfileState.phoneNumber,
    website: saveProfileState.website,
    summary: saveProfileState.summary,
    schools: saveProfileState.schools,
    jobs: saveProfileState.jobs,
    skills: saveProfileState.skills,
  ).toJson();
}