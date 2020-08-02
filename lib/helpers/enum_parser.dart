import '../constants/common_constants.dart';


String parseUserTypeToString(UserType type) {
  switch (type) {
    case UserType.mentor:
      return "mentor";
    case UserType.mentee:
      return "mentee";
    default:
      return '';
  }
}

UserType parseUserTypeToValue(String type) {
  switch (type) {
    case "mentor":
      return UserType.mentor;
    case "mentee":
      return UserType.mentee;
    default:
      return null;
  }
}

String parseAuthStatusToString(AuthStatus authStatus) {
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

AuthStatus parseAuthStatusToValue(String authStatus) {
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