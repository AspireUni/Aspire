import 'dart:convert';
import 'package:meta/meta.dart';

@immutable
class Message {
  final int type;
  final String timestamp;
  final String idTo;
  final String idFrom;
  final String content;
  final bool isRead;

  const Message({
    @required this.type,
    @required this.timestamp,
    @required this.idTo,
    @required this.idFrom,
    @required this.content,
    @required this.isRead,
  });

  factory Message.initial() {
    return Message(
      type: 0,
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      idTo: '',
      idFrom: '',
      content: '',
      isRead: false,
    );
  }

  Message copyWith({
    int type,
    String timestamp,
    String idTo,
    String idFrom,
    String content,
    bool isRead,
  }) {
    return Message(
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      idTo: idTo ?? this.idTo,
      idFrom: idFrom ?? this.idFrom,
      content: content ?? this.content,
      isRead: isRead ?? this.isRead,
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
        isRead: json["isRead"] as bool,
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
    'isRead': isRead,
  };

  @override
  String toString() {
    return 'Message: ${JsonEncoder.withIndent('  ').convert(this)}';
  }
}