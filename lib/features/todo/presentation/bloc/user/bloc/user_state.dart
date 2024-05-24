import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../domin/entity/user_entity.dart';

abstract class UserState extends Equatable {
  final UserEntity? user;
  final String? massege;

  final DioException? exception;
  const UserState({
    this.user,
    this.massege,
    this.exception,
  });

  @override
  List<Object?> get props => [user, massege, exception];
}

class UserInitState extends UserState {
  const UserInitState();
}

class UserLoadingState extends UserState {
  const UserLoadingState();
}

class UserErrorState extends UserState {
  const UserErrorState(DioException exception) : super(exception: exception);
}

class LoginUserDoneState extends UserState {
  const LoginUserDoneState(UserEntity user) : super(user: user);
}

class RefreshSessionDoneState extends UserState {
  const RefreshSessionDoneState(UserEntity user) : super(user: user);
}
class GetUserDoneState extends UserState {
  const GetUserDoneState(UserEntity user) : super(user: user);
}
