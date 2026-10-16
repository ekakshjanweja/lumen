import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../theme/theme.dart';
import 'ambient_background.dart';

/// A full-screen notice with an icon, short explanation and actions.
class MessageScreen extends StatelessWidget {
  const MessageScreen({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    this.action,
    this.error,
  });

  final IconData icon;
  final String title;
  final String body;
  final Widget? action;
  final String? error;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final reduced = Motion.reduced(context);

    Widget badge = Container(
      width: 104,
      height: 104,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: scheme.surfaceContainerHigh,
        border: Border.all(color: scheme.primary.withValues(alpha: 0.25)),
        boxShadow: [BoxShadow(color: scheme.primary.withValues(alpha: 0.22), blurRadius: 48)],
      ),
      child: Icon(icon, size: 44, color: scheme.primary),
    );
    if (!reduced) {
      badge = badge
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .moveY(begin: -4, end: 4, duration: 2200.ms, curve: Curves.easeInOutSine);
    }

    final children = <Widget>[
      badge,
      const SizedBox(height: 32),
      Text(title, textAlign: TextAlign.center, style: text.headlineSmall),
      const SizedBox(height: 10),
      Text(
        body,
        textAlign: TextAlign.center,
        style: text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
      ),
      if (error != null) ...[
        const SizedBox(height: 16),
        Text(
          error!,
          textAlign: TextAlign.center,
          style: TextStyle(color: scheme.error),
        ),
      ],
      if (action != null) ...[const SizedBox(height: 36), action!],
    ];

    return Scaffold(
      body: AmbientBackground(
        color: scheme.primary,
        level: 0.45,
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: reduced
                    ? children
                    : children
                          .animate(interval: 60.ms)
                          .fadeIn(duration: Motion.slow, curve: Motion.emphasized)
                          .moveY(begin: 14, end: 0, duration: Motion.slow, curve: Motion.emphasized),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
