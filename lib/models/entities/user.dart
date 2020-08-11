import 'dart:convert';
import 'package:meta/meta.dart';

import '../../constants/common_constants.dart';
import '../../helpers/helpers.dart';
import '../models.dart';


@immutable
class User {
  final String id;
  final UserType type;
  final bool isVerified;
  final bool isFtu;
  final String industry;
  final List<String> areas;
  final String fullName;
  final String emailAddress;
  final String phoneNumber;
  final String website;
  final String summary;
  final List<School> schools;
  final List<Job> jobs;
  final List<Skill> skills;

  const User({
    @required this.id,
    @required this.type,
    @required this.isVerified,
    @required this.isFtu,
    @required this.industry,
    @required this.areas,
    @required this.fullName,
    @required this.emailAddress,
    this.phoneNumber,
    this.website,
    this.summary,
    this.schools,
    this.jobs,
    this.skills,
  });

  factory User.initial() {
    return User(
      id: '',
      type: null,
      isVerified: false,
      isFtu: true,
      industry: '',
      areas: [],
      fullName: '',
      emailAddress: '',
      phoneNumber: '',
      website: '',
      summary: '',
      schools: [],
      jobs: [],
      skills: []
    );
  }

  User copyWith({
    String id,
    UserType type,
    bool isVerified,
    bool isFtu,
    String industry,
    List<String> areas,
    String fullName,
    String emailAddress,
    String phoneNumber,
    String website,
    String summary,
    List<School> schools,
    List<Job> jobs,
    List<Skill> skills
  }) {
    return User(
      id: id ?? this.id,
      type: type ?? this.type,
      isVerified: isVerified ?? this.isVerified,
      isFtu: isFtu ?? this.isFtu,
      industry: industry ?? this.industry,
      areas: areas ?? this.areas,
      fullName: fullName ?? this.fullName,
      emailAddress: emailAddress ?? this.emailAddress,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      website: website ?? this.website,
      summary: summary ?? this.summary,
      schools: schools ?? this.schools,
      jobs: jobs ?? this.jobs,
      skills: skills ?? this.skills
    );
  }

  static User fromJson(dynamic json) {
    var areasJson = json['areas'] as List;
    var schoolsJson = json['schools'] as List;
    var jobsJson = json['jobs'] as List;
    var skillsJson = json['skills'] as List;
    return User(
      id: json["id"] as String,
      type: parseUserTypeToValue(json["type"]),
      isVerified: json["isVerified"] as bool,
      isFtu: json["isFtu"] as bool,
      industry: json["industry"] as String,
      areas: areasJson?.map((area) => area as String)?.toList(),
      fullName: json["fullName"] as String,
      emailAddress: json["emailAddress"] as String,
      phoneNumber: json["phoneNumber"] as String,
      website: json["website"] as String,
      summary: json["summary"] as String,
      schools: schoolsJson?.map(School.fromJson)?.toList(),
      jobs: jobsJson?.map(Job.fromJson)?.toList(),
      skills: skillsJson?.map(Skill.fromJson)?.toList(),
    );
  }

  dynamic toJson() => {
    'id': id,
    'type': parseUserTypeToString(type),
    'isVerified': isVerified,
    'isFtu': isFtu,
    'industry': industry,
    'areas': areas?.map((area) => area)?.toList(),
    'fullName': fullName,
    'emailAddress': emailAddress,
    'phoneNumber': phoneNumber,
    'website': website,
    'summary': summary,
    'schools': schools?.map((school) => school.toJson())?.toList(),
    'jobs': jobs?.map((job) => job.toJson())?.toList(),
    'skills': skills?.map((skill) => skill.toJson())?.toList(),
  };

  @override
  String toString() {
    return 'User: ${JsonEncoder.withIndent('  ').convert(this)}';
  }
}