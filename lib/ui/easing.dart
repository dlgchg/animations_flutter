import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/*
 * @TIME 2019-03-27 21:58
 * @DES  TODO
 */

class EasingAnimation extends StatefulWidget {
  @override
  _EasingAnimationState createState() => _EasingAnimationState();
}

class _EasingAnimationState extends State<EasingAnimation>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    )..addStatusListener(_handler);
  }

  _handler(status) {
    if (status == AnimationStatus.completed) {
      _animation.removeStatusListener(_handler);
      _controller.reset();
      _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
      )..addStatusListener(
          (status) {
            if (status == AnimationStatus.completed) {
              Navigator.pop(context);
            }
          },
        );
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    _controller.forward();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.toString()),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.translationValues(
              _animation.value * width,
              0.0,
              0.0,
            ),
            child: Center(
              child: Container(
                width: 200.0,
                height: 200.0,
                color: Colors.blue,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
