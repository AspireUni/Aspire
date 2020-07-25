import '../constants/common_constants.dart';
import '../models/models.dart';

class UpdateUserState {
  final UserState payload;

  UpdateUserState(this.payload);
}

class ConvertToUserState {
  final dynamic payload;

  ConvertToUserState(this.payload);
}

class UpdateAuthStatus {
  final AuthStatus payload;

  UpdateAuthStatus(this.payload);
}

class UpdateIsFtu {
  final bool payload;

  UpdateIsFtu({this.payload});
}
