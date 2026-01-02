import 'package:flutter/material.dart';

import 'polygons/cube.dart';
import 'polygons/penguin.dart';
import 'render.dart';
import 'render_controller.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  final _controller = RenderController();
  final _boardSize = Size(800, 800);

  final _cube = Cube();
  final _penguin = Penguin();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: ListenableBuilder(
            listenable: _controller,
            builder: (context, _) {
              return Text('Delta ${_controller.delta.toStringAsFixed(4)}');
            },
          ),
        ),
        body: Center(
          child: RepaintBoundary(
            child: CustomPaint(
              size: _boardSize,
              painter: Render(
                controller: _controller,
                polygon: _cube,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
