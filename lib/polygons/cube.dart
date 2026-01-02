import 'package:flutter_3d_cube/polygons/polygon.dart';
import 'package:flutter_3d_cube/vector.dart';

class Cube extends Polygon {
  Cube()
    : super(
        showPoints: true,
        vertices: [
          Vector(x: 0.25, y: 0.25, z: 0.25),
          Vector(x: -0.25, y: 0.25, z: 0.25),
          Vector(x: -0.25, y: -0.25, z: 0.25),
          Vector(x: 0.25, y: -0.25, z: 0.25),
          Vector(x: 0.25, y: 0.25, z: -0.25),
          Vector(x: -0.25, y: 0.25, z: -0.25),
          Vector(x: -0.25, y: -0.25, z: -0.25),
          Vector(x: 0.25, y: -0.25, z: -0.25),
        ],
        indices: [
          [0, 1, 2, 3],
          [4, 5, 6, 7],
          [0, 4],
          [1, 5],
          [2, 6],
          [3, 7],
        ],
      );
}
