import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/*
 * @Date: 2019-03-28 10:08 
 * @Description TODO
 */

class ValueAnimation extends StatefulWidget {
  @override
  _ValueAnimationState createState() => _ValueAnimationState();
}

class _ValueAnimationState extends State<ValueAnimation> with TickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    final Animation curve =
    CurvedAnimation(parent: controller, curve: Curves.easeOut);
    animation = IntTween(begin: 0, end: 10).animate(curve)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        }
        if (status == AnimationStatus.dismissed) {
          Navigator.pop(context);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Scaffold(
              body: new Center(
                child: Text(animation.value.toString(), style: TextStyle(fontSize: 48.0)),
              ));
        });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
