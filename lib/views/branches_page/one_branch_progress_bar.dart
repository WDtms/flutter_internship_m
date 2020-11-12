import 'dart:math';

import 'package:flutter/material.dart';

class CircleProgressBar extends StatefulWidget {

  final Color completedColor;
  final progress;

  CircleProgressBar({this.progress, this.completedColor});

  @override
  _CircleProgressBarState createState() => _CircleProgressBarState();
}

class _CircleProgressBarState extends State<CircleProgressBar> with SingleTickerProviderStateMixin {

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
  void didUpdateWidget(CircleProgressBar oldWidget) {
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
       foregroundPainter: CircleProgress(animation.value, widget.completedColor), // this will add custom painter after child
       child: Container(
         width: 75,
         height: 75,
         child: Center(child: Text("${animation.value.toInt()} %",
               style: TextStyle(
                   fontSize: 17,
                   fontWeight: FontWeight.bold,
                   color: widget.completedColor
               ),
             )
          )
        )
     );
  }
}

class CircleProgress extends CustomPainter{

  Color completedColor;
  double currentProgress;

  CircleProgress(this.currentProgress, this.completedColor);

  @override
  void paint(Canvas canvas, Size size) {

    //this is base circle
    Paint outerCircle = Paint()
      ..strokeWidth = 4
      ..color = Color(0xffC4C4C4)
      ..style = PaintingStyle.stroke;

    Paint completeArc = Paint()
      ..strokeWidth = 4
      ..color = completedColor
      ..style = PaintingStyle.stroke
      ..strokeCap  = StrokeCap.round;

    Offset center = Offset(size.width/2, size.height/2);
    double radius = min(size.width/2,size.height/2) - 10;

    canvas.drawCircle(center, radius, outerCircle); // this draws main outer circle

    double angle;
    if (currentProgress == 0){
      angle = 0;
    } else{
      angle = 2 * pi * (currentProgress/100);
    }


    canvas.drawArc(Rect.fromCircle(center: center,radius: radius), -pi/2, angle, false, completeArc);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
