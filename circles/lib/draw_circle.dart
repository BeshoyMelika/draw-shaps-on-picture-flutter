import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';

// ignore: must_be_immutable
class DrawShapesWidget extends StatelessWidget {
  final Function(int) onTap;
  final List<Shape> shapes;
  DrawShapesWidget({
    Key key,
    @required this.shapes,
    @required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: CanvasTouchDetector(
        builder: (context) {
          return CustomPaint(
            painter: ShapesPainter(
              shapes: shapes,
              context: context,
              onTap: onTap,
            ),
          );
        },
      ),
    );
  }
}

class ShapesPainter extends CustomPainter {
  final List<Shape> shapes;
  final BuildContext context;
  final Function(int) onTap;

  ShapesPainter({
    @required this.context,
    @required this.shapes,
    @required this.onTap,
  });

  @override
  void paint(Canvas _canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;
    TouchyCanvas canvas = TouchyCanvas(context, _canvas);

    shapes.forEach((shape) {
      paint..color = shape.color;

      switch (shape.TypeOfShape) {
        case ShapeType.Circle:
          canvas.drawCircle(
              shape.points[0],
              circleRadius(shape.points[0], shape.points[1]),
              paint, onTapDown: (_) {
            onTap(shape.id);
          });
          break;
        case ShapeType.Rectangle:
          canvas.drawRect(
              Rect.fromPoints(shape.points[0], shape.points[1]), paint,
              onTapDown: (_) {
            onTap(shape.id);
          });
          break;
        case ShapeType.Polygon:
          Path path = Path();
          path.addPolygon(shape.points, true);
          path.close();
          canvas.drawPath(path, paint, onTapDown: (_) {
            onTap(shape.id);
          });
          break;
      }
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  double circleRadius(Offset centerPoint, Offset endPoint) =>
      Point(centerPoint.dx, centerPoint.dy)
          .distanceTo(Point(endPoint.dx, endPoint.dy));
}

class Shape {
  final List<Offset> points;
  final ShapeType TypeOfShape;
  final Color color;
  final int id;

  Shape(this.id, this.points, this.TypeOfShape, this.color);
}

enum ShapeType {
  Circle,
  Rectangle,
  Polygon,
}
