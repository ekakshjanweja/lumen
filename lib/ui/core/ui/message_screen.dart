import 'package:flutter/material.dart';

/// Expanding rings behind a bulb, used while searching.
class PulseRings extends StatefulWidget {
  const PulseRings({super.key, required this.active, this.color, this.size = 200});
  final bool active;
  final Color? color;
  final double size;

  @override
  State<PulseRings> createState() => _PulseRingsState();
}

class _PulseRingsState extends State<PulseRings> with SingleTickerProviderStateMixin {
  late final _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 2400));

  @override
  void initState() {
    super.initState();
    _sync();
  }

  @override
  void didUpdateWidget(PulseRings old) {
    super.didUpdateWidget(old);
    _sync();
  }

  void _sync() {
    final reduce = WidgetsBinding.instance.platformDispatcher.accessibilityFeatures.disableAnimations;
    if (widget.active && !reduce) {
      if (!_c.isAnimating) _c.repeat();
    } else {
      _c.stop();
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = widget.color ?? scheme.primary;
    final core = widget.size * 0.42;
    return SizedBox.square(
      dimension: widget.size,
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, _) => Stack(
          alignment: Alignment.center,
          children: [
            if (_c.isAnimating)
              for (final offset in [0.0, 0.33, 0.66])
                Builder(
                  builder: (context) {
                    final t = (_c.value + offset) % 1.0;
                    final d = core + (widget.size - core) * Curves.easeOut.transform(t);
                    return Container(
                      width: d,
                      height: d,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: color.withValues(alpha: 0.45 * (1 - t)), width: 1.5),
                      ),
                    );
                  },
                ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: core,
              height: core,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withValues(alpha: 0.16),
                boxShadow: [BoxShadow(color: color.withValues(alpha: 0.35), blurRadius: 40)],
              ),
              child: Icon(Icons.lightbulb_rounded, size: core * 0.42, color: color),
            ),
          ],
        ),
      ),
    );
  }
}

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
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(color: scheme.surfaceContainer, shape: BoxShape.circle),
                  child: Icon(icon, size: 40, color: scheme.onSurfaceVariant),
                ),
                const SizedBox(height: 24),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: text.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
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
                if (action != null) ...[const SizedBox(height: 28), action!],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
