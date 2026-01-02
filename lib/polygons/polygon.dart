import 'dart:ui';

import 'package:flutter_3d_cube/vector.dart';

class Polygon {
  final List<List<int>> indices;
  final List<Vector> vertices;
  final Color color;
  final int strokeWidth = 2;
  final bool showPoints;

  Polygon({
    this.color = const Color(0xFF00FF00),
    this.vertices = const [],
    this.indices = const [],
    this.showPoints = false,
  });
}
