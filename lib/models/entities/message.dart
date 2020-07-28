import 'dart:convert';
import 'package:meta/meta.dart';

import '../models.dart';

@immutable
class Message {
  final int type;
  final String timestamp;
  final String idTo;
  final String idFrom;
  final String content;

  const Message({
    @required this.type,
    @required this.timestamp,
    @required this.idTo,
    @required this.idFrom,
    @required this.content,
  });

  factory Message.initial() {
    return Message(
      type: 0,
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      idTo: '',
      idFrom: '',
      content: ''
    );
  }

  Message copyWith({
    int type,
    String timestamp,
    String idTo,
    String idFrom,
    String content,
  }) {
    return Message(
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      idTo: idTo ?? this.idTo,
      idFrom: idFrom ?? this.idFrom,
      content: content ?? this.content,
    );
  }

  static Message fromJson(dynamic json) {
    if (json != null) {
      return Message(
        type: json["type"] as int,
        timestamp: json["timestamp"] as String,
        idTo: json["idTo"] as String,
        idFrom: json["idFrom"] as String,
        content: json["content"] as String,
      );
    }
    return null;
  }

  dynamic toJson() => {
    'type': type,
    'timestamp': timestamp,
    'idTo': idTo,
    'idFrom': idFrom,
    'content': content,
  };

  @override
  String toString() {
    return 'Message: ${JsonEncoder.withIndent('  ').convert(this)}';
  }
}