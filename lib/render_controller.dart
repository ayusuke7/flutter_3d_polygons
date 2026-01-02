import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class RenderController extends ChangeNotifier {
  double targetFrameTime = 1000 / 60;
  double _previousTime = 0;
  double delta = 0;

  // Mova a lógica de estado para cá
  double dz = 1;
  double angle = 0;

  void start() {
    SchedulerBinding.instance.scheduleFrameCallback(_loop);
  }

  void _loop(Duration timeStamp) {
    SchedulerBinding.instance.scheduleFrameCallback(_loop);
    double currentTime = timeStamp.inMilliseconds.toDouble();

    if (_previousTime == 0) _previousTime = currentTime;

    double elapsed = currentTime - _previousTime;
    if (elapsed >= targetFrameTime) {
      delta = elapsed / 1000.0;
      _previousTime = currentTime;

      // dz += 1 * delta;
      angle += pi * delta / 2;

      notifyListeners();
    }
  }
}
