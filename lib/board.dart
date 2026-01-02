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
  final _controller = RenderController(
    polygon: Cube(),
  );
  final _boardSize = Size(800, 800);

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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: ListenableBuilder(
            listenable: _controller,
            builder: (context, _) {
              return Row(
                spacing: 20.0,
                children: [
                  TextButton.icon(
                    label: Text('Cube'),
                    icon: Icon(
                      _controller.polygon is Cube
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                    ),
                    onPressed: () {
                      if (_controller.polygon is Cube) return;

                      _controller.polygon = Cube();
                    },
                  ),
                  TextButton.icon(
                    label: Text('Penguin'),
                    icon: Icon(
                      _controller.polygon is Penguin
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                    ),
                    onPressed: () {
                      if (_controller.polygon is Penguin) return;

                      _controller.polygon = Penguin();
                    },
                  ),
                  Spacer(),
                  TextButton.icon(
                    label: Text('Lines'),
                    icon: Icon(
                      _controller.showLines
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                    ),
                    onPressed: () {
                      _controller.showLines = !_controller.showLines;
                    },
                  ),
                  TextButton.icon(
                    label: Text('Points'),
                    icon: Icon(
                      _controller.showPoints
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                    ),
                    onPressed: () {
                      _controller.showPoints = !_controller.showPoints;
                    },
                  ),
                ],
              );
            },
          ),
        ),
        body: Center(
          child: RepaintBoundary(
            child: CustomPaint(
              size: _boardSize,
              painter: Render(
                controller: _controller,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
