import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/resources/data_state.dart';

import '../../../../domin/usecases/user.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final LoginUserUseCase _loginUserUseCase;
  final RefreshSessionUserUseCase _refreshSessionUserUseCase;
  final GetUserUserUseCase _getUserUserUseCase;

  UserBloc(this._loginUserUseCase, this._refreshSessionUserUseCase,
      this._getUserUserUseCase)
      : super(const UserInitState()) {
    on<LoginUser>(onLoginUser);
    on<GetUser>(onGetUser);
    on<RefreshSession>(onRefreshSession);
  }

  void onLoginUser(LoginUser event, Emitter<UserState> emit) async {
    emit(const UserLoadingState());

    final dataState = await _loginUserUseCase(params: event.userEntity);

    if (dataState is DataSuccess) {
      emit(LoginUserDoneState(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(UserErrorState(dataState.exception!));
    }
  }

  void onGetUser(GetUser event, Emitter<UserState> emit) async {
    final dataState = await _getUserUserUseCase();

    if (dataState is DataSuccess) {
      emit(GetUserDoneState(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(UserErrorState(dataState.exception!));
    }
  }

  void onRefreshSession(RefreshSession event, Emitter<UserState> emit) async {
    final dataState = await _refreshSessionUserUseCase();

    if (dataState is DataSuccess) {
      emit(RefreshSessionDoneState(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(UserErrorState(dataState.exception!));
    }
  }
}
