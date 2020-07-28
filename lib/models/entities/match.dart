import 'dart:convert';
import 'package:meta/meta.dart';

import '../models.dart';

@immutable
class Match {
  final String matchId;
  final bool hasContacted;
  final List<String> pair;
  final Message lastMessage;

  const Match({
    @required this.matchId,
    @required this.pair,
    this.hasContacted,
    this.lastMessage,
  });

  factory Match.initial() {
    return Match(
      matchId: '',
      hasContacted: false,
      pair: [],
      lastMessage: null
    );
  }

  Match copyWith({
    String matchId,
    bool hasContacted,
    List<String> pair,
    Message lastMessage,
  }) {
    return Match(
      matchId: matchId ?? this.matchId,
      hasContacted: hasContacted ?? this.hasContacted,
      pair: pair ?? this.pair,
      lastMessage: lastMessage ?? this.lastMessage
    );
  }

  static Match fromJson(dynamic json) {
    var pairJson = (json['pair'] as List<dynamic>).cast<String>();
    return Match(
      matchId: json["matchId"] as String,
      hasContacted: json["hasContacted"] as bool,
      pair: pairJson?.toList(),
      lastMessage: Message.fromJson(json["lastMessage"])
    );
  }

  dynamic toJson() => {
    'matchId': matchId,
    'hasContacted': hasContacted,
    'pair': pair?.toList(),
    'lastMessage': lastMessage.toJson()
  };

  @override
  String toString() {
    return 'Match: ${JsonEncoder.withIndent('  ').convert(this)}';
  }
}