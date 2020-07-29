import 'dart:convert';
import 'package:meta/meta.dart';

import '../../constants/common_constants.dart';
import '../../helpers/helpers.dart';
import '../models.dart';


@immutable
class UserState {
  final String id;
  final UserType type;
  final bool isFtu;
  final AuthStatus authStatus;
  final SaveProfileState saveProfileState;

  const UserState({
    @required this.id,
    @required this.type,
    @required this.isFtu,
    this.authStatus,
    this.saveProfileState
  });

  factory UserState.initial() {
    return UserState(
      id: '',
      type: null,
      isFtu: true,
      authStatus: AuthStatus.notDetermined,
      saveProfileState: SaveProfileState.initial()
    );
  }

  UserState copyWith({
    String id,
    UserType type,
    bool isFtu,
    AuthStatus authStatus,
    SaveProfileState saveProfileState
  }) {
    return UserState(
      id: id ?? this.id,
      type: type ?? this.type,
      isFtu: isFtu ?? this.isFtu,
      authStatus: authStatus ?? this.authStatus,
      saveProfileState: saveProfileState ?? this.saveProfileState
    );
  }

  static UserState fromJson(dynamic json) {
    return UserState(
      id: json["id"] as String,
      type: parseUserTypeToValue(json["type"]),
      isFtu: json["isFtu"] as bool,
      authStatus: parseAuthStatusToValue(json["authStatus"]),
      saveProfileState: SaveProfileState.fromJson(json["saveProfileState"])
    );
  }

  dynamic toJson() => {
    'id': id,
    'type': parseUserTypeToString(type),
    'isFtu': isFtu,
    'authStatus': parseAuthStatusToString(authStatus),
    'saveProfileState': saveProfileState.toJson()
  };

  @override
  String toString() {
    return 'UserState: ${JsonEncoder.withIndent('  ').convert(this)}';
  }
}