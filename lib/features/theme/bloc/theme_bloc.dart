import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../theme_storage.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(themeMode: ThemeMode.system)) {
    on<LoadThemeEvent>(_onLoadTheme);
    on<ChangeThemeEvent>(_onChangeTheme);
  }

  // Load from storage
  Future<void> _onLoadTheme(
    LoadThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final mode = await ThemeStorage.loadTheme();
    emit(state.copyWith(themeMode: mode));
  }

  // Change theme
  Future<void> _onChangeTheme(
    ChangeThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    await ThemeStorage.saveTheme(event.themeMode);

    emit(state.copyWith(themeMode: event.themeMode));
  }
}
