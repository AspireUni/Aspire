import 'package:redux/redux.dart';

import '../actions/actions.dart';
import '../models/models.dart';

final userReducer = TypedReducer<User, dynamic>(_updateUserReducer);

User _updateUserReducer(User user, dynamic action) {
  if (action is UpdateUser) {
    return action.payload;
  }
  if (action is UpdateFullName) {
    return user.copyWith(fullName: action.payload);
  }
  if (action is UpdateSummary) {
    return user.copyWith(summary: action.payload);
  }
  if (action is AddSchool) {
    return user.copyWith(
      schools: [
        ...?user.schools,
        action.payload
      ]
    );
  }
  if (action is UpdateSchool) {
    var schools = user.schools.map((school) {
      if (school.id == action.payload.id) {
        return action.payload;
      }
      return school;
    }).toList();

    return user.copyWith(
      schools: schools
    );
  }
  if (action is AddJob) {
    return user.copyWith(
      jobs: [
        ...?user.jobs,
        action.payload
      ]
    );
  }
  if (action is UpdateJob) {
    var jobs = user.jobs.map((job) {
      if (job.id == action.payload.id) {
        return action.payload;
      }
      return job;
    }).toList();

    return user.copyWith(
      jobs: jobs
    );
  }
  if (action is AddSkill) {
    return user.copyWith(
      skills: [
        ...?user.skills,
        action.payload
      ]
    );
  }
  if (action is UpdateSkill) {
    var skills = user.skills.map((skill) {
      if (skill.id == action.payload.id) {
        return action.payload;
      }
      return skill;
    }).toList();

    return user.copyWith(
      skills: skills
    );
  }
  if (action is UpdateContact) {
    return user.copyWith(
      contact: action.payload
    );
  }
  return user;
}