import 'package:flutter/material.dart';

abstract class ThemeEvent {}

// Load saved theme
class LoadThemeEvent extends ThemeEvent {}

// Change theme
class ChangeThemeEvent extends ThemeEvent {
  final ThemeMode themeMode;

  ChangeThemeEvent(this.themeMode);
}
