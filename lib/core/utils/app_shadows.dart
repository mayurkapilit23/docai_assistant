import 'package:flutter/material.dart';

/// Centralized reusable shadow styles
class AppShadows {
  AppShadows._();

  /// Very subtle shadow (barely visible)
  static List<BoxShadow> subtle = [
    BoxShadow(
      color: Colors.black.withOpacity(.03),
      blurRadius: 1,
      offset: const Offset(0, 1),
    ),
  ];

  /// Light shadow (small elevation)
  static List<BoxShadow> light = [
    BoxShadow(
      color: Colors.black.withOpacity(.05),
      blurRadius: 2,
      offset: const Offset(0, 2),
    ),
  ];

  /// Medium shadow (default card style)
  static List<BoxShadow> medium = [
    BoxShadow(
      color: Colors.black.withOpacity(.1),
      blurRadius: 6,
      offset: const Offset(0, 4),
    ),
  ];

  /// Heavy shadow (for modals, floating elements)
  static List<BoxShadow> heavy = [
    BoxShadow(
      color: Colors.black.withOpacity(.2),
      blurRadius: 12,
      offset: const Offset(0, 6),
    ),
  ];
}
