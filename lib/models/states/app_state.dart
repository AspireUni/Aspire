import 'dart:convert';
import 'package:meta/meta.dart';

import '../models.dart';

@immutable
class AppState {
  final UserState userState;

  const AppState({
    @required this.userState,
  });

  factory AppState.initial() {
    return AppState(
      userState: UserState.initial(),
    );
  }

  AppState copyWith({
    UserState userState,
  }) {
    return AppState(
      userState: userState ?? this.userState
    );
  }

  static AppState fromJson(dynamic json) { 
    if (json != null) {
      return AppState(
        userState: UserState.fromJson(json["userState"])
      );
    }
    return AppState.initial();
  }
  dynamic toJson() => {
    'userState': userState,
  };

  @override
  String toString() {
    return 'AppState: ${JsonEncoder.withIndent('  ').convert(this)}';
  }
}