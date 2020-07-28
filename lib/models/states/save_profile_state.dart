import 'dart:convert';
import 'package:meta/meta.dart';

import '../models.dart';


@immutable
class SaveProfileState {
  final String fullName;
  final String summary;
  final List<School> schools;
  final List<Job> jobs;
  final List<Skill> skills;
  final Contact contact;
  final School saveEducationState;
  final Job saveExperienceState;
  final Skill saveSkillState;

  const SaveProfileState({
    this.fullName,
    this.summary,
    this.schools,
    this.jobs,
    this.skills,
    this.contact,
    this.saveEducationState,
    this.saveExperienceState,
    this.saveSkillState
  });

  factory SaveProfileState.initial() {
    return SaveProfileState(
      fullName: '',
      summary: '',
      schools: [],
      jobs: [],
      skills: [],
      contact: Contact.initial(),
      saveEducationState: School.initial(),
      saveExperienceState: Job.initial(),
      saveSkillState: Skill.initial()
    );
  }

  SaveProfileState copyWith({
    String fullName,
    String summary,
    List<School> schools,
    List<Job> jobs,
    List<Skill> skills,
    Contact contact,
    School saveEducationState,
    Job saveExperienceState,
    Skill saveSkillState
  }) {
    return SaveProfileState(
      fullName: fullName ?? this.fullName,
      summary: summary ?? this.summary,
      schools: schools ?? this.schools,
      jobs: jobs ?? this.jobs,
      skills: skills ?? this.skills,
      contact: contact ?? this.contact,
      saveEducationState: saveEducationState ?? this.saveEducationState,
      saveExperienceState: saveExperienceState ?? this.saveExperienceState,
      saveSkillState: saveSkillState ?? this.saveSkillState
    );
  }

  static SaveProfileState fromJson(dynamic json) {
    var schoolsJson = json['schools'] as List;
    var jobsJson = json['jobs'] as List;
    var skillsJson = json['skills'] as List;
    return SaveProfileState(
      fullName: json["fullName"] as String,
      summary: json["summary"] as String,
      schools: schoolsJson?.map(School.fromJson)?.toList(),
      jobs: jobsJson?.map(Job.fromJson)?.toList(),
      skills: skillsJson?.map(Skill.fromJson)?.toList(),
      contact: Contact.fromJson(json["contact"]),
      saveEducationState: School.fromJson(json["saveEducationState"]),
      saveExperienceState: Job.fromJson(json["saveExperienceState"]),
      saveSkillState: Skill.fromJson(json["saveSkillState"])
    );
  }

  dynamic toJson() => {
    'fullName': fullName,
    'summary': summary,
    'schools': schools?.map((school) => school.toJson())?.toList(),
    'jobs': jobs?.map((job) => job.toJson())?.toList(),
    'skills': skills?.map((skill) => skill.toJson())?.toList(),
    'contact': contact.toJson(),
    'saveEducationState': saveEducationState.toJson(),
    'saveExperienceState': saveExperienceState.toJson(),
    'saveSkillState': saveSkillState.toJson()
  };

  @override
  String toString() {
    return 'SaveProfileState: ${JsonEncoder.withIndent('  ').convert(this)}';
  }
}