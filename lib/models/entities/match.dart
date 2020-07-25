import 'dart:convert';
import 'package:meta/meta.dart';

import '../models.dart';

@immutable
class Match {
  final bool hasContacted;
  final List<User> pair;
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
      lastMessage: Message.initial()
    );
  }

  Match copyWith({
    bool hasContacted,
    List<User> pair,
  }) {
    return Match(
      hasContacted: hasContacted ?? this.hasContacted,
      pair: pair ?? this.pair,
    );
  }

  static Match fromJson(dynamic json) {
    var pairJson = json['pair'] as List;
    return Match(
      hasContacted: json["hasContacted"] as bool,
      pair: pairJson?.map(User.fromJson)?.toList(),
    );
  }

  dynamic toJson() => {
    'hasContacted': hasContacted,
    'pair': pair?.map((user) => user.toJson())?.toList(),
  };

  @override
  String toString() {
    return 'Match: ${JsonEncoder.withIndent('  ').convert(this)}';
  }
}