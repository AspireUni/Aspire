import 'dart:convert';
import 'package:meta/meta.dart';

import '../models.dart';


@immutable
class SaveProfileState {
  final String fullName;
  final String emailAddress;
  final String phoneNumber;
  final String website;
  final String summary;
  final List<School> schools;
  final List<Job> jobs;
  final List<Skill> skills;
  final School saveEducationState;
  final Job saveExperienceState;
  final Skill saveSkillState;

  const SaveProfileState({
    this.fullName,
    this.emailAddress,
    this.phoneNumber,
    this.website,
    this.summary,
    this.schools,
    this.jobs,
    this.skills,
    this.saveEducationState,
    this.saveExperienceState,
    this.saveSkillState
  });

  factory SaveProfileState.initial() {
    return SaveProfileState(
      fullName: '',
      emailAddress: '',
      phoneNumber: '',
      website: '',
      summary: '',
      schools: [],
      jobs: [],
      skills: [],
      saveEducationState: School.initial(),
      saveExperienceState: Job.initial(),
      saveSkillState: Skill.initial()
    );
  }

  SaveProfileState copyWith({
    String fullName,
    String emailAddress,
    String phoneNumber,
    String website,
    String summary,
    List<School> schools,
    List<Job> jobs,
    List<Skill> skills,
    School saveEducationState,
    Job saveExperienceState,
    Skill saveSkillState
  }) {
    return SaveProfileState(
      fullName: fullName ?? this.fullName,
      emailAddress: emailAddress ?? this.emailAddress,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      website: website ?? this.website,
      summary: summary ?? this.summary,
      schools: schools ?? this.schools,
      jobs: jobs ?? this.jobs,
      skills: skills ?? this.skills,
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
      emailAddress: json["emailAddress"] as String,
      phoneNumber: json["phoneNumber"] as String,
      website: json["website"] as String,
      summary: json["summary"] as String,
      schools: schoolsJson?.map(School.fromJson)?.toList(),
      jobs: jobsJson?.map(Job.fromJson)?.toList(),
      skills: skillsJson?.map(Skill.fromJson)?.toList(),
      saveEducationState: School.fromJson(json["saveEducationState"]),
      saveExperienceState: Job.fromJson(json["saveExperienceState"]),
      saveSkillState: Skill.fromJson(json["saveSkillState"])
    );
  }

  dynamic toJson() => {
    'fullName': fullName,
    'emailAddress': emailAddress,
    'phoneNumber': phoneNumber,
    'website': website,
    'summary': summary,
    'schools': schools?.map((school) => school.toJson())?.toList(),
    'jobs': jobs?.map((job) => job.toJson())?.toList(),
    'skills': skills?.map((skill) => skill.toJson())?.toList(),
    'saveEducationState': saveEducationState.toJson(),
    'saveExperienceState': saveExperienceState.toJson(),
    'saveSkillState': saveSkillState.toJson()
  };

  @override
  String toString() {
    return 'SaveProfileState: ${JsonEncoder.withIndent('  ').convert(this)}';
  }
}