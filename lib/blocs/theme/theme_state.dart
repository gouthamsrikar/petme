part of 'theme_bloc.dart';

sealed class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState(this.themeMode);

  @override
  List<Object> get props => [];
}

class LightThemeState extends ThemeState {
  const LightThemeState({ThemeMode? themeMode})
      : super(themeMode ?? ThemeMode.light);
}

class DarkThemeState extends ThemeState {
  const DarkThemeState({ThemeMode? themeMode})
      : super(themeMode ?? ThemeMode.dark);
}
