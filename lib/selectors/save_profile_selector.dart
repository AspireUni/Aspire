import 'package:redux/redux.dart';

import '../actions/actions.dart';
import '../models/models.dart';

SaveProfileState saveProfileStateSelector(Store<AppState> store) {
  return store.state.userState.saveProfileState;
}

String userIdSelector(Store<AppState> store) {
  return store.state.userState.id
;}

Contact contactSelector(Store<AppState> store) {
  return store.state.userState.saveProfileState.contact;
}

List<School> schoolListSelector(Store<AppState> store) {
  return store.state.userState.saveProfileState.schools;
}

School schoolSelector(Store<AppState> store, String id) {
  School school;
  school = store.state.userState.saveProfileState.schools?.singleWhere(
    (school) => id == school.id,
    orElse: () => null
  );
  return school;
}

List<Job> jobListSelector(Store<AppState> store) {
  return store.state.userState.saveProfileState.jobs;
}

Job jobSelector(Store<AppState> store, String id) {
  Job job;
  job = store.state.userState.saveProfileState.jobs?.singleWhere(
    (job) => id == job.id,
    orElse: () => null
  );
  return job;
}

List<Skill> skillListSelector(Store<AppState> store) {
  return store.state.userState.saveProfileState.skills;
}

Skill skillSelector(Store<AppState> store, String id) {
  Skill skill;
  skill = store.state.userState.saveProfileState.skills?.singleWhere(
    (skill) => id == skill.id,
    orElse: () => null
  );
  return skill;
}

School saveEducationStateSelector(
  Store<AppState> store, {
    String id, 
    bool editMode,
    bool isPageActive
  }) {
    var state = store.state.userState.saveProfileState.saveEducationState;
    if (id != null && state.id == '' && isPageActive) {
      School school;
      if (editMode) {
        school = schoolSelector(store, id);
      } else {
        school = School.initial().copyWith(id: id);
      }
      store.dispatch(UpdateSaveEducationState(school));
      return school;
    }
    return state;
}

Job saveExperienceStateSelector(
  Store<AppState> store, {
    String id, 
    bool editMode,
    bool isPageActive
  }) {
    var state = store.state.userState.saveProfileState.saveExperienceState;
    if (id != null && state.id == ''  && isPageActive) {
      Job job;
      if (editMode) {
        job = jobSelector(store, id);
      } else {
        job = Job.initial().copyWith(id: id);
      }
      store.dispatch(UpdateSaveExperienceState(job));
      return job;
    }
    return state;
}

Skill saveSkillStateSelector(
  Store<AppState> store, {
    String id, 
    bool editMode,
    bool isPageActive
  }) {
    var state = store.state.userState.saveProfileState.saveSkillState;
    if (id != null && state.id == ''  && isPageActive) {
      Skill skill;
      if (editMode) {
        skill = skillSelector(store, id);
      } else {
        skill = Skill.initial().copyWith(id: id);
      }
      store.dispatch(UpdateSaveSkillState(skill));
      return skill;
    }
    return state;
}

