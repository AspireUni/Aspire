import 'dart:convert';
import 'package:meta/meta.dart';

@immutable
class School {
  final String id;
  final String name;
  final String program;
  final String startYear;
  final String endYear;

  const School({
    @required this.id,
    @required this.name,
    @required this.program,
    @required this.startYear,
    @required this.endYear
  });

  factory School.initial() {
    return School(
      id: '',
      name: '',
      program: '',
      startYear: null,
      endYear: null
    );
  }

  School copyWith({
    String id,
    String name,
    String program,
    String startYear,
    String endYear,
  }) {
    return School(
      id: id ?? this.id,
      name: name ?? this.name,
      program: program ?? this.program,
      startYear: startYear ?? this.startYear,
      endYear: endYear
    );
  }

  static School fromJson(dynamic json) =>
    School(
      id: json["id"] as String,
      name: json["name"] as String,
      program: json["program"] as String,
      startYear: json["startYear"] as String,
      endYear: json["endYear"] as String
    );

  dynamic toJson() => {
    'id': id,
    'name': name,
    'program': program,
    'startYear': startYear,
    'endYear': endYear
  };

  @override
  String toString() {
    return 'School: ${JsonEncoder.withIndent('  ').convert(this)}';
  }
}