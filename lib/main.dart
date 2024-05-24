import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/features/todo/presentation/bloc/task/bloc/task_bloc.dart';

import 'config/bloc_integration.dart';
import 'config/di.dart';
import 'config/theme/bloc/theme_app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/todo/presentation/bloc/user/bloc/user_bloc.dart';
import 'features/todo/presentation/pages/signin_screen.dart';
import 'features/todo/presentation/pages/task_page.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setup();
  await initializeDependencies();

  Bloc.observer = MyBlocObserver();
  runApp(BlocProvider<ThemeAppBloc>(
    create: (context) => sl<ThemeAppBloc>()..add(SetInitialThemeApp()),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => sl<UserBloc>(),
        ),
        BlocProvider<TaskBloc>(
          create: (context) => sl<TaskBloc>(),
        )
      ],
      child: BlocBuilder<ThemeAppBloc, ThemeData>(
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: state,
              // home: Artbord1(),
              home: 
              (config.get<SharedPreferences>().getString('token') != null)
              // ? PageFirst()
              ? const TaskPage()
              : const SignInScreen(),
              );
        },
      ),
    );
  }
}
