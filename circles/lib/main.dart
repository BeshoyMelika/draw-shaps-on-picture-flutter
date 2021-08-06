import 'dart:ui';

import 'package:flutter/material.dart';

import 'draw_circle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Custom Painter',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyPainter(),
      // home: Screen1(),
    );
  }
}

class MyPainter extends StatefulWidget {
  @override
  _MyPainterState createState() => _MyPainterState();
}

class _MyPainterState extends State<MyPainter> {
  double scale = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draw'),
      ),
      body: Column(
        children: [
          SizedBox(height: 100),
          InteractiveViewer(
            onInteractionUpdate: (details) {
              setState(() {
                scale = details.scale;
              });
            },
            maxScale: 10,
            child: Container(
              height: 500,
              width: double.infinity,
              color: Colors.red,
              child: Column(
                children: [
                  photosss(),
                  FlutterLogo(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Shape> sh = [
  Shape(1, [Offset(140, 150), Offset(150, 180)], ShapeType.Circle,
      Color.fromRGBO(99, 120, 22, .5)),
  Shape(2, [Offset(100, 20), Offset(180, 70)], ShapeType.Rectangle,
      Color.fromRGBO(299, 120, 122, .5)),
  Shape(
      2,
      [
        Offset(80, 260),
        Offset(300, 80),
        Offset(260, 320),
        Offset(210, 250),
      ],
      ShapeType.Polygon,
      Color.fromRGBO(299, 12, 122, .5)),
];

class photosss extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: SizedBox(
        height: 400,
        child: InteractiveViewer(
          onInteractionStart: (details) {
            print("Start");
          },
          child: Stack(
            children: [
              Image.network(
                  "https://fiverr-res.cloudinary.com/images/t_main1,q_auto,f_auto,q_auto,f_auto/gigs/153129468/original/4eb3c930659ce032791104e01abfec9679002e14/2d-maps-for-civil-and-floor-map-house-flats-full-floors.jpg"),
              DrawShapesWidget(
                shapes: sh,
                onTap: (id) {
                  print(id);
                },
              ),
              // Container(
              //   height: double.infinity,
              //   width: double.infinity,
              //   color: Colors.transparent,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
