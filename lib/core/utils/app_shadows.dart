import 'package:flutter/material.dart';

class AppShadows {
  /// Subtle shadow for cards or containers
  static List<BoxShadow> subtle = [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  /// Medium shadow for elevated components
  static List<BoxShadow> medium = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  /// Strong shadow for modals or floating elements
  static List<BoxShadow> strong = [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 12,
      offset: const Offset(0, 6),
    ),
  ];

  /// Glow-like shadow (e.g., for highlights)
  static List<BoxShadow> glow(Color color) => [
    BoxShadow(color: color.withOpacity(0.6), blurRadius: 16, spreadRadius: 2),
  ];
}
