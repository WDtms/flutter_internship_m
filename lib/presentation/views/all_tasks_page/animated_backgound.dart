import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/presentation/constants/my_images.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedBackground extends StatefulWidget {

  final bool isFiltred;

  AnimatedBackground({this.isFiltred});

  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> with SingleTickerProviderStateMixin {

  AnimationController progressController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    progressController = AnimationController(vsync: this, duration: Duration(milliseconds: 220));
    animation = Tween<double>(begin: 0.01, end: 1).animate(progressController)..addListener((){
      setState(() {
      });
    });
    progressController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment(0, -0.2),
          child: Opacity(
            opacity: animation.value,
            child: SvgPicture.asset(
              task_big_circle,
              height: 200*animation.value,
              width: 200*animation.value,
            ),
          ),
        ),
        Align(
          alignment: Alignment(0, -0.2),
          child: Opacity(
            opacity: animation.value,
            child: SvgPicture.asset(
              task_small_circle,
              height: 180*animation.value,
              width: 180*animation.value,
            ),
          ),
        ),
        Align(
          alignment: Alignment(0, (-0.7 + 0.5*animation.value)),
          child: SvgPicture.asset(
            task_empty_table,
            height: 200,
            width: 200,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/6),
          child: Align(
            alignment: Alignment(0, 0.3),
            child: Opacity(
              opacity: animation.value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Builder(
                  builder: (context) {
                    if (widget.isFiltred == true){
                      return Text(
                          'На данный момент в этой ветке нет невыполненных задач',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff545454).withOpacity(animation.value),
                          )
                      );
                    }
                    return Text(
                    'На данный момент в этой ветке нет задач',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff545454).withOpacity(animation.value)
                    ),
                    );
                  },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
