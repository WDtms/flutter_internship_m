import 'package:flutter/material.dart';

class SelectedCircle extends StatefulWidget {

  final double radius;

  SelectedCircle({this.radius});

  @override
  _SelectedCircleState createState() => _SelectedCircleState();
}

class _SelectedCircleState extends State<SelectedCircle> with SingleTickerProviderStateMixin {

  AnimationController progressController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    progressController = AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    animation = Tween<double>(begin: 0, end: widget.radius).animate(progressController)..addListener((){
      setState(() {

      });
    });
    progressController.forward();
  }

  @override
  void didUpdateWidget(SelectedCircle oldWidget) {
    if (oldWidget.radius != widget.radius){
      animation = Tween<double>(begin: 0, end: widget.radius).animate(progressController)..addListener((){
        setState(() {

        });
      });
      progressController
        ..reset()
        ..forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        foregroundPainter: MySelectedCircle(radius: animation.value),
        child: Container(
          height: widget.radius,
          width: widget.radius,
        ),
      ),
    );
  }
}

class MySelectedCircle extends CustomPainter{

  final radius;

  MySelectedCircle({this.radius});

  @override
  void paint(Canvas canvas, Size size) {

    Paint selectedCircle = Paint()
      ..strokeWidth = 30
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeCap  = StrokeCap.round;

    canvas.drawCircle(Offset(radius/2,radius/2), radius, selectedCircle);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
