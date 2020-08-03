import 'dart:convert';
import 'package:meta/meta.dart';

@immutable
class Industry {
  final String name;
  final List<String> areas;

  const Industry({
    @required this.name,
    @required this.areas,
  });

  factory Industry.initial() {
    return Industry(
      name: '',
      areas: []
    );
  }

  Industry copyWith({
    String name,
    List<String> areas,
  }) {
    return Industry(
      name: name ?? this.name,
      areas: areas ?? this.areas
    );
  }

  static Industry fromJson(dynamic json) {
    var areasJson = json['areas'] as List;
    return Industry(
      name: json["name"] as String,
      areas: areasJson?.map((area) => area as String)?.toList()
    );
  }

  dynamic toJson() => {
    'name': name,
    'areas': areas?.map((area) => area)?.toList()
  };

  @override
  String toString() {
    return 'Industry: ${JsonEncoder.withIndent('  ').convert(this)}';
  }
}