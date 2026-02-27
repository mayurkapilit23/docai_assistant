import 'dart:ui';

import 'package:flutter/material.dart';

class AppThemeColors extends ThemeExtension<AppThemeColors> {
  final Color textPrimary;
  final Color textSecondary;
  final Color border;
  final Color hint;

  // 👇 Chat colors
  final Color userBubble;
  final Color botBubble;
  final Color userText;
  final Color botText;

  const AppThemeColors({
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.hint,

    required this.userBubble,
    required this.botBubble,
    required this.userText,
    required this.botText,
  });

  @override
  AppThemeColors copyWith({
    Color? textPrimary,
    Color? textSecondary,
    Color? border,
    Color? hint,

    Color? userBubble,
    Color? botBubble,
    Color? userText,
    Color? botText,
  }) {
    return AppThemeColors(
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      border: border ?? this.border,
      hint: hint ?? this.hint,

      userBubble: userBubble ?? this.userBubble,
      botBubble: botBubble ?? this.botBubble,
      userText: userText ?? this.userText,
      botText: botText ?? this.botText,
    );
  }

  @override
  AppThemeColors lerp(AppThemeColors? other, double t) {
    if (other is! AppThemeColors) return this;

    return AppThemeColors(
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      border: Color.lerp(border, other.border, t)!,
      hint: Color.lerp(hint, other.hint, t)!,

      userBubble: Color.lerp(userBubble, other.userBubble, t)!,
      botBubble: Color.lerp(botBubble, other.botBubble, t)!,
      userText: Color.lerp(userText, other.userText, t)!,
      botText: Color.lerp(botText, other.botText, t)!,
    );
  }
}
