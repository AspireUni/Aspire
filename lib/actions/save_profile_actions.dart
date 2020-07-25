import '../models/models.dart';

class UpdateSaveProfileState {
  final SaveProfileState payload;
  UpdateSaveProfileState(this.payload);
}

class ConvertToSaveProfileState {
  final dynamic payload;
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

class SaveSchool {
  final bool payload;
  SaveSchool({this.payload});
}

class DeleteSchool {}

class SaveJob {
  final bool payload;
  SaveJob({this.payload});
}

class DeleteJob {}

class SaveSkill {
  final bool payload;
  SaveSkill({this.payload});
}

class DeleteSkill {}

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