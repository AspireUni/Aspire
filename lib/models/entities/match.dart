import 'dart:convert';
import 'package:meta/meta.dart';

import '../models.dart';

@immutable
class Match {
  final bool hasContacted;
  final List<String> pair;
  final Message lastMessage;

  const Match({
    @required this.pair,
    this.hasContacted,
    this.lastMessage,
  });

  factory Match.initial() {
    return Match(
      hasContacted: false,
      pair: [],
      lastMessage: null
    );
  }

  Match copyWith({
    bool hasContacted,
    List<String> pair,
  }) {
    return Match(
      hasContacted: hasContacted ?? this.hasContacted,
      pair: pair ?? this.pair,
    );
  }

  static Match fromJson(dynamic json) {
    var pairJson = (json['pair'] as List<dynamic>).cast<String>();
    return Match(
      hasContacted: json["hasContacted"] as bool,
      pair: pairJson?.toList(),
    );
  }

  dynamic toJson() => {
    'hasContacted': hasContacted,
    'pair': pair?.toList(),
  };

  @override
  String toString() {
    return 'Match: ${JsonEncoder.withIndent('  ').convert(this)}';
  }
}