import 'package:todo_app/core/resources/data_state.dart';
import 'package:todo_app/core/usecases/usecase.dart';

import '../entity/user_entity.dart';
import '../repository/user_repository.dart';

class LoginUserUseCase implements UseCase<DataState<UserEntity>, UserEntity> {
  final UserRepository _userRepository;

  LoginUserUseCase(this._userRepository);

  @override
  Future<DataState<UserEntity>> call({UserEntity? params}) {
    return _userRepository.login(newUserEntity: params!);
  }
}

class RefreshSessionUserUseCase
    implements UseCase<DataState<UserEntity>, void> {
  final UserRepository _userRepository;

  RefreshSessionUserUseCase(this._userRepository);

  @override
  Future<DataState<UserEntity>> call({void params}) {
    return _userRepository.refreshSession();
  }
}

class GetUserUserUseCase implements UseCase<DataState<UserEntity>, void> {
  final UserRepository _userRepository;

  GetUserUserUseCase(this._userRepository);

  @override
  Future<DataState<UserEntity>> call({void params}) {
    return _userRepository.getUser();
  }
}
