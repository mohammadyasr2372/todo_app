import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'config/theme/bloc/theme_app_bloc.dart';
import 'features/todo/data/data_sources/local/app_database.dart';
import 'features/todo/data/data_sources/remote/task_api_service.dart';
import 'features/todo/data/data_sources/remote/user_api_service.dart';
import 'features/todo/data/repository/task_repository_impl.dart';
import 'features/todo/data/repository/user_repository_impl.dart';
import 'features/todo/domin/repository/task_repository.dart';
import 'features/todo/domin/repository/user_repository.dart';
import 'features/todo/domin/usecases/task.dart';
import 'features/todo/domin/usecases/user.dart';
import 'features/todo/presentation/bloc/task/bloc/task_bloc.dart';
import 'features/todo/presentation/bloc/user/bloc/user_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies\

  sl.registerSingleton<TaskApiService>(TaskApiService(sl()));
  sl.registerSingleton<TaskRepository>(TaskRepositoryImpl(sl(), sl()));

  sl.registerSingleton<UserApiService>(UserApiService(sl()));
  sl.registerSingleton<UserRepository>(UserRepositoryImpl(sl()));

  //UseCases

  sl.registerSingleton<GetAllTodosByUserIdUseCase>(
      GetAllTodosByUserIdUseCase(sl()));
  sl.registerSingleton<LimitAndSkipTodosUseCase>(
      LimitAndSkipTodosUseCase(sl()));
  sl.registerSingleton<GetTaskInfoUseCase>(GetTaskInfoUseCase(sl()));
  sl.registerSingleton<PostTaskUseCase>(PostTaskUseCase(sl()));
  sl.registerSingleton<PutTaskUseCase>(PutTaskUseCase(sl()));
  sl.registerSingleton<DeletTaskUseCase>(DeletTaskUseCase(sl()));
  sl.registerSingleton<GetSavedTaskUseCase>(GetSavedTaskUseCase(sl()));
  sl.registerSingleton<SaveTaskUseCase>(SaveTaskUseCase(sl()));
  sl.registerSingleton<RemoveTaskUseCase>(RemoveTaskUseCase(sl()));

  sl.registerSingleton<LoginUserUseCase>(LoginUserUseCase(sl()));
  sl.registerSingleton<RefreshSessionUserUseCase>(
      RefreshSessionUserUseCase(sl()));
  sl.registerSingleton<GetUserUserUseCase>(GetUserUserUseCase(sl()));

  // Blocs

  sl.registerFactory<TaskBloc>(
      () => TaskBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()));

  sl.registerFactory<UserBloc>(() => UserBloc(sl(), sl(), sl()));

  sl.registerFactory<ThemeAppBloc>(() => ThemeAppBloc());
}
