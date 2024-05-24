import 'package:todo_app/core/resources/data_state.dart';

import '../entity/user_entity.dart';

abstract class UserRepository {
  // API methods
  Future<DataState<UserEntity>> login({required UserEntity newUserEntity});
  Future<DataState<UserEntity>> getUser();
  Future<DataState<UserEntity>> refreshSession();
}
