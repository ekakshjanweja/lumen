import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

/// Seconds of animation time, for painters that animate forever. Pausing and
/// resuming carries on from where it stopped instead of jumping.
class LoopClock extends ValueNotifier<double> {
  LoopClock(TickerProvider vsync) : super(0) {
    _ticker = vsync.createTicker((elapsed) => value = _base + elapsed.inMicroseconds / 1e6);
  }

  late final Ticker _ticker;
  double _base = 0;

  bool get running => _ticker.isActive;

  set running(bool run) {
    if (run == _ticker.isActive) return;
    if (run) {
      _ticker.start();
    } else {
      _base = value;
      _ticker.stop();
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }
}
