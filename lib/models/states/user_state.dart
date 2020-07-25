import 'dart:convert';
import 'package:meta/meta.dart';

import '../../constants/common_constants.dart';
import '../models.dart';


@immutable
class UserState {
  final String id;
  final bool isFtu;
  final AuthStatus authStatus;
  final SaveProfileState saveProfileState;

  const UserState({
    @required this.id,
    @required this.isFtu,
    this.authStatus,
    this.saveProfileState
  });

  factory UserState.initial() {
    return UserState(
      id: '',
      isFtu: true,
      authStatus: AuthStatus.notDetermined,
      saveProfileState: SaveProfileState.initial()
    );
  }

  UserState copyWith({
    String id,
    bool isFtu,
    AuthStatus authStatus,
    SaveProfileState saveProfileState
  }) {
    return UserState(
      id: id ?? this.id,
      isFtu: isFtu ?? this.isFtu,
      authStatus: authStatus ?? this.authStatus,
      saveProfileState: saveProfileState ?? this.saveProfileState
    );
  }

  static UserState fromJson(dynamic json) {
    return UserState(
      id: json["id"] as String,
      isFtu: json["isFtu"] as bool,
      authStatus: parseAuthStatusToValue(json["authStatus"]),
      saveProfileState: SaveProfileState.fromJson(json["saveProfileState"])
    );
  }

  dynamic toJson() => {
    'id': id,
    'isFtu': isFtu,
    'authStatus': parseAuthStatusToString(authStatus),
    'saveProfileState': saveProfileState.toJson()
  };

  static String parseAuthStatusToString(AuthStatus authStatus) {
    switch (authStatus) {
      case AuthStatus.notDetermined:
        return "notDetermined";
      case AuthStatus.notLoggedIn:
        return "notLoggedIn";
      case AuthStatus.loggedIn:
        return "loggedIn";
      default:
        return "notDetermined";
    }
  }

  static AuthStatus parseAuthStatusToValue(String authStatus) {
    switch (authStatus) {
      case "notDetermined":
        return AuthStatus.notDetermined;
      case "notLoggedIn":
        return AuthStatus.notLoggedIn;
      case "loggedIn":
        return AuthStatus.loggedIn;
      default:
        return AuthStatus.notDetermined;
    }
  }

  @override
  String toString() {
    return 'UserState: ${JsonEncoder.withIndent('  ').convert(this)}';
  }
}