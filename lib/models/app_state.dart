import 'dart:convert';
import 'package:meta/meta.dart';

import './models.dart';

@immutable
class AppState {
  final User user;

  const AppState({
    @required this.user,
  });

  factory AppState.initial() {
    return AppState(
      user: User.initial(),
    );
  }

  AppState copyWith({@required User user}) {
    return AppState(user: user ?? this.user);
  }

  static AppState fromJson(dynamic json) => 
    AppState(user: User.fromJson(json["user"]));
  
  dynamic toJson() => {
      'user': user,
    };

  @override
  String toString() {
    return 'AppState: ${JsonEncoder.withIndent('  ').convert(this)}';
  }
}