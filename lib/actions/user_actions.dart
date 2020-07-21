import '../models/models.dart';

class UpdateUser {
  final User payload;

  UpdateUser(this.payload);
}

class UpdateFullName {
  final String payload;

  UpdateFullName(this.payload);
}

class UpdateSummary {
  final String payload;

  UpdateSummary(this.payload);
}

class UpdateSchool {
  final School payload;

  UpdateSchool(this.payload);
}

class AddSchool {
  final School payload;

  AddSchool(this.payload);
}

class UpdateJob {
  final Job payload;

  UpdateJob(this.payload);
}

class AddJob {
  final Job payload;

  AddJob(this.payload);
}

class UpdateSkill {
  final Skill payload;

  UpdateSkill(this.payload);
}

class AddSkill {
  final Skill payload;

  AddSkill(this.payload);
}

class UpdateContact {
  final Contact payload;

  UpdateContact(this.payload);
}