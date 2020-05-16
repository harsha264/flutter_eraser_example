import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          painter: Painter(),
          child: Container(),
        ),
      ),
    );
  }
}

class Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // default blendMode=BlendMode.srcOver
    final _blendMode = BlendMode.clear;

    // let's pretend this rectangle is an image.
    // in this case, we don't want anything removed from the image, 
    // and we also want the image to be drawn under the eraser.
    canvas.drawRect(Rect.fromLTWH(100, 100, 100, 100), Paint()..color=Colors.white);

    // after having drawn our image, we start a new layer using saveLayer().
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());

    // drawing the line that should be erased partially.
    canvas.drawLine(
        Offset(100, 100), Offset(200, 200), Paint()..color = Colors.black..strokeWidth = 5.0);

    // erasing parts of the first line where intersected with this line.
    canvas.drawLine(
        Offset(100, 200), Offset(200, 100), Paint()..color=Colors.red..strokeWidth = 5.0..blendMode=_blendMode);
    
    // first composite this layer and then draw it over the previously drawn layers.
    canvas.restore();
    
    // move on with other draw commands...
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
