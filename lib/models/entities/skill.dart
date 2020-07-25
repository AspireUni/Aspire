import 'dart:convert';
import 'package:meta/meta.dart';

@immutable
class Skill {
  final String id;
  final String name;
  final String level;

  const Skill({
    @required this.id,
    @required this.name,
    @required this.level,
  });

  factory Skill.initial() {
    return Skill(
      id: '',
      name: '',
      level: null,
    );
  }

  Skill copyWith({
    String id,
    String name,
    String level
  }) {
    return Skill(
      id: id ?? this.id,
      name: name ?? this.name,
      level: level ?? this.level,
    );
  }

  static Skill fromJson(dynamic json) =>
    Skill(
      id: json["id"] as String,
      name: json["name"] as String,
      level: json["level"] as String,
    );

  dynamic toJson() => {
    'id': id,
    'name': name,
    'level': level
  };

  @override
  String toString() {
    return 'Skill: ${JsonEncoder.withIndent('  ').convert(this)}';
  }
}