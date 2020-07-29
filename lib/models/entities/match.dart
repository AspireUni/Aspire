import 'dart:convert';
import 'package:meta/meta.dart';

import '../models.dart';

@immutable
class Match {
  final String matchId;
  final bool hasContacted;
  final User mentee;
  final User mentor;
  final Message lastMessage;
  final String matchedDate;

  const Match({
    @required this.matchId,
    @required this.mentee,
    @required this.mentor,
    this.hasContacted,
    this.lastMessage,
    this.matchedDate,
  });

  factory Match.initial() {
    return Match(
      matchId: '',
      hasContacted: false,
      mentee: User.initial(),
      mentor: User.initial(),
      lastMessage: null,
      matchedDate: '',
    );
  }

  Match copyWith({
    String matchId,
    bool hasContacted,
    User mentee,
    User mentor,
    Message lastMessage,
    String matchedDate,
  }) {
    return Match(
      matchId: matchId ?? this.matchId,
      hasContacted: hasContacted ?? this.hasContacted,
      mentee: mentee ?? this.mentee,
      mentor: mentor ?? this.mentor,
      lastMessage: lastMessage ?? this.lastMessage,
      matchedDate: matchedDate ?? this.matchedDate
    );
  }

  static Match fromJson(dynamic json) {
    return Match(
      matchId: json["matchId"] as String,
      hasContacted: json["hasContacted"] as bool,
      mentee: User.fromJson(json["mentee"]),
      mentor: User.fromJson(json["mentor"]),
      lastMessage: Message.fromJson(json["lastMessage"]),
      matchedDate: json["matchedDate"] as String
    );
  }

  dynamic toJson() => {
    'matchId': matchId,
    'hasContacted': hasContacted,
    'mentee': mentee.toJson(),
    'mentor': mentor.toJson(),
    'lastMessage': lastMessage.toJson(),
    'matchedDate': matchedDate
  };

  @override
  String toString() {
    return 'Match: ${JsonEncoder.withIndent('  ').convert(this)}';
  }
}