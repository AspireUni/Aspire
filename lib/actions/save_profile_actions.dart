import '../models/models.dart';

class UpdateSaveProfileState {
  final SaveProfileState payload;

  UpdateSaveProfileState(this.payload);
}

class ConvertToSaveProfileState {
  final User payload;

  ConvertToSaveProfileState(this.payload);
}

class UpdateFullName {
  final String payload;

  UpdateFullName(this.payload);
}

class UpdateSummary {
  final String payload;

  UpdateSummary(this.payload);
}

class UpdateContact {
  final Contact payload;

  UpdateContact(this.payload);
}

class UpdateSchool {
  UpdateSchool();
}

class AddSchool {
  AddSchool();
}

class DeleteSchool {
  DeleteSchool();
}

class UpdateJob {
  UpdateJob();
}

class AddJob {
  AddJob();
}

class DeleteJob {
  DeleteJob();
}

class UpdateSkill {
  UpdateSkill();
}

class AddSkill {
  AddSkill();
}

class DeleteSkill {
  DeleteSkill();
}

class UpdateSaveEducationState {
  final School payload;

  UpdateSaveEducationState(this.payload);
}

class UpdateSaveExperienceState {
  final Job payload;

  UpdateSaveExperienceState(this.payload);
}

class UpdateSaveSkillState {
  final Skill payload;

  UpdateSaveSkillState(this.payload);
}