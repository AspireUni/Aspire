import 'package:redux/redux.dart';

import '../actions/actions.dart';
import '../models/models.dart';

final saveProfileStateReducer
  = TypedReducer<SaveProfileState, dynamic>(_saveProfileStateReducer);

SaveProfileState _saveProfileStateReducer(
  SaveProfileState state,
  dynamic action
) {
  if (action is UpdateSaveProfileState) {
    return action.payload;
  }
  if (action is ConvertToSaveProfileState) {
    return SaveProfileState.initial().copyWith(
      fullName: action.payload.fullName,
      summary: action.payload.summary,
      contact: action.payload.contact,
      schools: action.payload.schools,
      skills: action.payload.skills,
      jobs: action.payload.jobs
    );
  }
  if (action is UpdateFullName) {
    return state.copyWith(fullName: action.payload);
  }
  if (action is UpdateSummary) {
    return state.copyWith(summary: action.payload);
  }
  if (action is AddSchool) {
    return state.copyWith(
      schools: [
        ...?state.schools,
        state.saveEducationState
      ],
      saveEducationState: School.initial()
    );
  }
  if (action is UpdateSchool) {
    var schools = state.schools.map((school) {
      if (school.id == state.saveEducationState.id) {
        return state.saveEducationState;
      }
      return school;
    }).toList();
    return state.copyWith(
      schools: schools,
      saveEducationState: School.initial()
    );
  }
  if (action is DeleteSchool) {
    state.schools.removeWhere((school) => 
      school.id == state.saveEducationState.id
    );
    return state.copyWith(
      saveEducationState: School.initial()
    );
  }
  if (action is AddJob) {
    return state.copyWith(
      jobs: [
        ...?state.jobs,
        state.saveExperienceState
      ],
      saveExperienceState: Job.initial()
    );
  }
  if (action is UpdateJob) {
    var jobs = state.jobs.map((job) {
      if (job.id == state.saveExperienceState.id) {
        return state.saveExperienceState;
      }
      return job;
    }).toList();
    return state.copyWith(
      jobs: jobs,
      saveExperienceState: Job.initial()
    );
  }
  if (action is DeleteJob) {
    state.jobs.removeWhere((job) => 
      job.id == state.saveExperienceState.id
    );
    return state.copyWith(
      saveExperienceState: Job.initial()
    );
  }
  if (action is AddSkill) {
    return state.copyWith(
      skills: [
        ...?state.skills,
        state.saveSkillState
      ],
      saveSkillState: Skill.initial()
    );
  }
  if (action is UpdateSkill) {
    var skills = state.skills.map((skill) {
      if (skill.id == state.saveSkillState.id) {
        return state.saveSkillState;
      }
      return skill;
    }).toList();
    return state.copyWith(
      skills: skills,
      saveSkillState: Skill.initial()
    );
  }
  if (action is DeleteSkill) {
    state.skills.removeWhere((skill) => 
      skill.id == state.saveSkillState.id
    );
    return state.copyWith(
      saveSkillState: Skill.initial()
    );
  }
  if (action is UpdateContact) {
    return state.copyWith(
      contact: action.payload
    );
  }
  if (action is UpdateSaveEducationState) {
    return state.copyWith(
      saveEducationState: action.payload
    );
  }
  if (action is UpdateSaveExperienceState) {
    return state.copyWith(
      saveExperienceState: action.payload
    );
  }
  if (action is UpdateSaveSkillState) {
    return state.copyWith(
      saveSkillState: action.payload
    );
  }
  return state;
}