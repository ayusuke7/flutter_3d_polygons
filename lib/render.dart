import 'dart:math';

import 'package:flutter/rendering.dart';

import 'render_controller.dart';
import 'vector.dart';

class Render extends CustomPainter {
  final RenderController controller;
  final Color backgroundColor;

  Render({
    required this.controller,
    this.backgroundColor = const Color(0xFF000000),
  }) : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    _clear(canvas, size);

    if (controller.showPoints) {
      for (final v in controller.polygon.vertices) {
        _drawPoint(
          canvas,
          controller.polygon.color,
          _transform(size, v),
        );
      }
    }

    if (controller.showLines) {
      for (final line in controller.polygon.indices) {
        for (int i = 0; i < line.length; i++) {
          final p1 = controller.polygon.vertices[line[i]];
          final p2 = controller.polygon.vertices[line[(i + 1) % line.length]];

          final v1 = _transform(size, p1);
          final v2 = _transform(size, p2);

          _drawLine(canvas, controller.polygon.color, v1, v2);
        }
      }
    }
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }

  void _clear(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = backgroundColor,
    );
  }

  void _drawPoint(Canvas canvas, Color color, Vector vector) {
    final s = 10.0;
    final x = vector.x - s / 2;
    final y = vector.y - s / 2;

    canvas.drawRect(
      Rect.fromLTWH(x, y, s, s),
      Paint()..color = color,
    );
  }

  void _drawLine(Canvas canvas, Color color, Vector vector1, Vector vector2) {
    canvas.drawLine(
      Offset(vector1.x, vector1.y),
      Offset(vector2.x, vector2.y),
      Paint()
        ..color = color
        ..strokeWidth = 1.5,
    );
  }

  Vector _rotateXZ(Vector vector, double angle) {
    final c = cos(angle);
    final s = sin(angle);

    return Vector(
      x: vector.x * c - vector.z * s,
      y: vector.y,
      z: vector.x * s + vector.z * c,
    );
  }

  Vector _translateZ(Vector vector, double dz) {
    return Vector(
      x: vector.x,
      y: vector.y,
      z: vector.z + dz,
    );
  }

  Vector _project(Vector vector) {
    return Vector(
      x: vector.x / vector.z,
      y: vector.y / vector.z,
    );
  }

  Vector _normalize(Size size, Vector vector) {
    return Vector(
      x: (vector.x + 1) / 2 * size.width,
      y: (1 - (vector.y + 1) / 2) * size.height,
    );
  }

  Vector _transform(Size size, Vector vector) {
    final rotate = _rotateXZ(
      vector,
      controller.angle,
    );
    final translate = _translateZ(
      rotate,
      controller.dz,
    );
    return _normalize(size, _project(translate));
  }
}
