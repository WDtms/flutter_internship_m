import 'package:flutter/material.dart';

class HorizontalProgressBar extends StatefulWidget {

  final double progress;

  HorizontalProgressBar({this.progress});

  @override
  _HorizontalProgressBarState createState() => _HorizontalProgressBarState();
}

class _HorizontalProgressBarState extends State<HorizontalProgressBar> with SingleTickerProviderStateMixin {

  AnimationController progressController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    progressController = AnimationController(vsync: this, duration: Duration(milliseconds: 1500));
    animation = Tween<double>(begin: 0, end: widget.progress*100).animate(progressController)..addListener((){
      setState(() {

      });
    });
    progressController.forward();
  }

  @override
  void didUpdateWidget(HorizontalProgressBar oldWidget) {
    if (oldWidget.progress != widget.progress){
      animation = Tween<double>(begin: 0, end: widget.progress*100).animate(progressController)..addListener((){
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
    return CustomPaint(
      foregroundPainter: MyHorizontalProgressBar(progress: animation.value),
      child: Container(
        height: 30,
        width: 150,
      ),
    );
  }
}

class MyHorizontalProgressBar extends CustomPainter{

  final progress;

  MyHorizontalProgressBar({this.progress});

  @override
  void paint(Canvas canvas, Size size) {

    Paint line = Paint()
      ..strokeWidth = 15
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap  = StrokeCap.round;

    Paint completedLine = Paint()
      ..strokeWidth = 15
      ..color = Colors.teal
      ..style = PaintingStyle.stroke
      ..strokeCap  = StrokeCap.round;

    final p1 = Offset(0, 0);
    final p2 = Offset(size.width, 0);
    Offset as;

    if (progress == 0) {
      as = Offset(0,0);
    }
    else {
      as = Offset(size.width * progress / 100, 0);
    }

    canvas.drawLine(p1, p2, line);
    canvas.drawLine(p1, as, completedLine);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
