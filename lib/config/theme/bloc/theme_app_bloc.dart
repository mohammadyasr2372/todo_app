// ignore_for_file: await_only_futures

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di.dart';
import 'theme_app_state.dart';

part 'theme_app_event.dart';

class ThemeAppBloc extends Bloc<ThemeAppEvent, ThemeData> {
  ThemeAppBloc() : super(ThemeData()) {
    on<SetInitialThemeApp>((event, emit) async {
      bool hasThemeDark = await isDark();
      emit(hasThemeDark ? darkThemeData() : lightThemeData());
    });

    on<SwitcherThemeApp>((event, emit) async {
      bool hasThemeDark = state == darkThemeData();
      emit(hasThemeDark ? lightThemeData() : darkThemeData());
      setTheme(isDark: !hasThemeDark);
    });
  }
}

Future<bool> isDark() async {
  return await config.get<SharedPreferences>().getBool('is_dark') ?? false;
}

Future<void> setTheme({required bool isDark}) async {
  await config.get<SharedPreferences>().setBool('is_dark', isDark);
}
