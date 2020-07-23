import 'package:redux/redux.dart';

import '../actions/actions.dart';
import '../models/models.dart';

User userSelector(Store<AppState> store) {
  return store.state.user;
}

Contact contactSelector(Store<AppState> store) {
  return store.state.user.contact;
}

List<School> schoolListSelector(Store<AppState> store) {
  return store.state.user.schools;
}

School schoolSelector(Store<AppState> store, String id) {
  School school;
  school = store.state.user.schools?.singleWhere(
    (school) => id == school.id,
    orElse: () => null
  );
  if (school == null) {
    school = School.initial().copyWith(id: id);
    store.dispatch(AddSchool(school));
  }
  return school;
}

List<Job> jobListSelector(Store<AppState> store) {
  return store.state.user.jobs;
}

Job jobSelector(Store<AppState> store, String id) {
  Job job;
  job = store.state.user.jobs?.singleWhere(
    (job) => id == job.id,
    orElse: () => null
  );
  if (job == null) {
    job = Job.initial().copyWith(id: id);
    store.dispatch(AddJob(job));
  }
  return job;
}

List<Skill> skillListSelector(Store<AppState> store) {
  return store.state.user.skills;
}

Skill skillSelector(Store<AppState> store, String id) {
  Skill skill;
  skill = store.state.user.skills?.singleWhere(
    (skill) => id == skill.id,
    orElse: () => null
  );
  if (skill == null) {
    skill = Skill.initial().copyWith(id: id);
    store.dispatch(AddSkill(skill));
  }
  return skill;
}