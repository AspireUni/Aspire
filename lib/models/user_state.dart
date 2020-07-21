import 'dart:convert';
import 'package:meta/meta.dart';

import './models.dart';

@immutable
class User {
  final String userID;
  final String fullName;
  final String summary;
  final List<School> schools;
  final List<Job> jobs;
  final List<Skill> skills;
  final Contact contact;

  const User({
    @required this.userID,
    @required this.contact,
    this.fullName,
    this.summary,
    this.schools,
    this.jobs,
    this.skills
  });

  factory User.initial() {
    return User(
      userID: '',
      fullName: '',
      summary: '',
      schools: [],
      jobs: [],
      skills: [],
      contact: Contact.initial()
    );
  }

  User copyWith({
    String fullName,
    String summary,
    List<School> schools,
    List<Job> jobs,
    List<Skill> skills,
    Contact contact
  }) {
    return User(
      userID: userID,
      fullName: fullName ?? this.fullName,
      summary: summary ?? this.summary,
      schools: schools ?? this.schools,
      jobs: jobs ?? this.jobs,
      skills: skills ?? this.skills,
      contact: contact ?? this.contact
    );
  }

  static User fromJson(dynamic json) {
    var schoolsJson = json['schools'] as List;
    var jobsJson = json['jobs'] as List;
    var skillsJson = json['skills'] as List;
    return User(
      userID: json["userID"] as String,
      fullName: json["fullName"] as String,
      summary: json["summary"] as String,
      schools: schoolsJson?.map(School.fromJson)?.toList(),
      jobs: jobsJson?.map(Job.fromJson)?.toList(),
      skills: skillsJson?.map(Skill.fromJson)?.toList(),
      contact: Contact.fromJson(json["contact"])
    );
  }

  dynamic toJson() => {
      'userID': userID,
      'fullName': fullName,
      'summary': summary,
      'schools': schools,
      'jobs': jobs,
      'skills': skills,
      'contact': contact,
    };

  @override
  String toString() {
    return 'User: ${JsonEncoder.withIndent('  ').convert(this)}';
  }
}