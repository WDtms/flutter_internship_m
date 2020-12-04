import 'package:flutter/material.dart';

class HorizontalProgressBar extends StatefulWidget {

  final double progress;

  HorizontalProgressBar({this.progress});

  @override
  _HorizontalProgressBarState createState() => _HorizontalProgressBarState();
}

class _HorizontalProgressBarState extends State<HorizontalProgressBar> with SingleTickerProviderStateMixin {

  AnimationController _progressController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(vsync: this, duration: Duration(milliseconds: 1500));
    _animation = Tween<double>(begin: 0, end: widget.progress*100).animate(_progressController)..addListener((){
      setState(() {

      });
    });
    _progressController.forward();
  }

  @override
  void didUpdateWidget(HorizontalProgressBar oldWidget) {
    if (oldWidget.progress != widget.progress){
      _animation = Tween<double>(begin: 0, end: widget.progress*100).animate(_progressController)..addListener((){
        setState(() {

        });
      });
      _progressController
        ..reset()
        ..forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: MyHorizontalProgressBar(progress: _animation.value),
      child: Container(
        height: 20,
        width: MediaQuery.of(context).size.width/2,
      ),
    );
  }
}

class MyHorizontalProgressBar extends CustomPainter{

  final progress;

  MyHorizontalProgressBar({this.progress});

  @override
  void paint(Canvas canvas, Size size) {

    Paint backgroundLine = Paint()
      ..strokeWidth = 17
      ..color = Color(0xff01A39D)
      ..style = PaintingStyle.stroke
      ..strokeCap  = StrokeCap.round;

    Paint line = Paint()
      ..strokeWidth = 15
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap  = StrokeCap.round;

    Paint completedLine = Paint()
      ..strokeWidth = 15
      ..color = Color(0xff01A39D)
      ..style = PaintingStyle.stroke
      ..strokeCap  = StrokeCap.round;

    final p1 = Offset(0.5, 0);
    final p2 = Offset(size.width, 0);
    final p3 = Offset(size.width+0.5, 0);
    final p4 = Offset(0, 0);
    Offset as;


    canvas.drawLine(p4, p3, backgroundLine);
    canvas.drawLine(p1, p2, line);
    if (progress == 0) {
      as = Offset(0,0);
    }
    else {
      as = Offset(size.width * progress / 100, 0);
      canvas.drawLine(p1, as, completedLine);
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
