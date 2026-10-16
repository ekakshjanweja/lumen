import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const background = Color(0xFF0E0E12);

  static ThemeData get dark {
    final scheme = ColorScheme.fromSeed(seedColor: const Color(0xFFFFC266), brightness: Brightness.dark).copyWith(
      surface: background,
      surfaceContainer: const Color(0xFF18181E),
      surfaceContainerHighest: const Color(0xFF24242C),
    );
    return ThemeData(colorScheme: scheme, scaffoldBackgroundColor: scheme.surface);
  }
}
