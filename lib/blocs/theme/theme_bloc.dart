import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:petme/theme/app_theme.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(LightThemeState(themeMode: ThemeMode.system)) {
    on<ThemeEvent>(
      (event, emit) {
        if (event is ToggleThemeEvent) {
          if (state is LightThemeState) {
            emit(DarkThemeState());
          } else {
            emit(LightThemeState());
          }
        }
      },
    );
  }
}
