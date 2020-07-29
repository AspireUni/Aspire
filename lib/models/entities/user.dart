import 'dart:convert';
import 'package:meta/meta.dart';

import '../../constants/common_constants.dart';
import '../../helpers/helpers.dart';
import '../models.dart';


@immutable
class User {
  final String id;
  final UserType type;
  final bool isFtu;
  final String fullName;
  final String summary;
  final List<School> schools;
  final List<Job> jobs;
  final List<Skill> skills;
  final Contact contact;

  const User({
    @required this.id,
    @required this.type,
    @required this.isFtu,
    @required this.contact,
    this.fullName,
    this.summary,
    this.schools,
    this.jobs,
    this.skills,
  });

  factory User.initial() {
    return User(
      id: '',
      type: null,
      isFtu: true,
      fullName: '',
      summary: '',
      schools: [],
      jobs: [],
      skills: [],
      contact: Contact.initial(),
    );
  }

  User copyWith({
    String id,
    UserType type,
    bool isFtu,
    String fullName,
    String summary,
    List<School> schools,
    List<Job> jobs,
    List<Skill> skills,
    Contact contact,
  }) {
    return User(
      id: id ?? this.id,
      type: type ?? this.type,
      isFtu: isFtu ?? this.isFtu,
      fullName: fullName ?? this.fullName,
      summary: summary ?? this.summary,
      schools: schools ?? this.schools,
      jobs: jobs ?? this.jobs,
      skills: skills ?? this.skills,
      contact: contact ?? this.contact,
    );
  }

  static User fromJson(dynamic json) {
    var schoolsJson = json['schools'] as List;
    var jobsJson = json['jobs'] as List;
    var skillsJson = json['skills'] as List;
    return User(
      id: json["id"] as String,
      type: parseUserTypeToValue(json["type"]),
      isFtu: json["isFtu"] as bool,
      fullName: json["fullName"] as String,
      summary: json["summary"] as String,
      schools: schoolsJson?.map(School.fromJson)?.toList(),
      jobs: jobsJson?.map(Job.fromJson)?.toList(),
      skills: skillsJson?.map(Skill.fromJson)?.toList(),
      contact: Contact.fromJson(json["contact"]),
    );
  }

  dynamic toJson() => {
    'id': id,
    'type': parseUserTypeToString(type),
    'isFtu': isFtu,
    'fullName': fullName,
    'summary': summary,
    'schools': schools?.map((school) => school.toJson())?.toList(),
    'jobs': jobs?.map((job) => job.toJson())?.toList(),
    'skills': skills?.map((skill) => skill.toJson())?.toList(),
    'contact': contact.toJson(),
  };

  @override
  String toString() {
    return 'User: ${JsonEncoder.withIndent('  ').convert(this)}';
  }
}