// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../../domin/entity/user_entity.dart';

abstract class UserEvent {
  const UserEvent();
}

class LoginUser extends UserEvent {
  UserEntity userEntity;
  LoginUser({
    required this.userEntity,
  });
}

class RefreshSession extends UserEvent {
  RefreshSession();
}

class GetUser extends UserEvent {
  GetUser();
}
