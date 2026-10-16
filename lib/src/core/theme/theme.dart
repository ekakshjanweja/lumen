import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const background = Color(0xFF0E0E12);
  static const accent = Color(0xFFFFC266);

  /// Translucent fill for cards that sit over the ambient glow.
  static const glass = Color(0x14FFFFFF);
  static const glassBorder = Color(0x14FFFFFF);

  static ThemeData get dark {
    final scheme = ColorScheme.fromSeed(seedColor: accent, brightness: Brightness.dark).copyWith(
      primary: accent,
      onPrimary: const Color(0xFF231600),
      surface: background,
      surfaceContainer: const Color(0xFF16161C),
      surfaceContainerHigh: const Color(0xFF1D1D24),
      surfaceContainerHighest: const Color(0xFF26262F),
      onSurfaceVariant: const Color(0xFF9D9DAB),
    );
    final base = ThemeData(colorScheme: scheme, fontFamily: 'Manrope');
    final text = base.textTheme.copyWith(
      displaySmall: base.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -1.5),
      headlineMedium: base.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.8),
      headlineSmall: base.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.6),
      titleMedium: base.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
      titleSmall: base.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
      labelLarge: base.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
      labelMedium: base.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
    );
    const buttonText = TextStyle(fontFamily: 'Manrope', fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0);

    return base.copyWith(
      scaffoldBackgroundColor: background,
      textTheme: text,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(58),
          shape: const StadiumBorder(),
          textStyle: buttonText,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: const StadiumBorder(),
          foregroundColor: scheme.onSurface,
          textStyle: buttonText,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surfaceContainerHigh,
        showDragHandle: true,
        dragHandleColor: scheme.onSurfaceVariant.withValues(alpha: 0.4),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(10)),
        textStyle: TextStyle(color: scheme.onSurface, fontFamily: 'Manrope', fontWeight: FontWeight.w600),
      ),
    );
  }
}

/// Shared durations and curves, so motion feels the same everywhere.
abstract final class Motion {
  static const fast = Duration(milliseconds: 160);
  static const medium = Duration(milliseconds: 300);
  static const slow = Duration(milliseconds: 500);

  /// Quick start, long gentle settle.
  static const emphasized = Cubic(0.2, 0, 0, 1);

  /// Settles with a small overshoot, for things that slide into place.
  static const spring = Cubic(0.34, 1.32, 0.64, 1);

  /// Whether looping and decorative motion should be skipped.
  static bool reduced(BuildContext context) => MediaQuery.maybeDisableAnimationsOf(context) ?? false;
}
