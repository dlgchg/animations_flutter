import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/*
 * @Date: 2019-03-28 09:13 
 * @Description TODO
 */

class OffsetAnimation extends StatefulWidget {
  @override
  _OffsetAnimationState createState() => _OffsetAnimationState();
}

class _OffsetAnimationState extends State<OffsetAnimation>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation, _lateAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    )..addStatusListener(_handler);
    _lateAnimation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.2, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
  }

  _handler(status) {
    if (status == AnimationStatus.completed) {
      _animation.removeStatusListener(_handler);
      _controller.reset();
      _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.fastOutSlowIn,
        ),
      );
      _lateAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(0.2, 1.0, curve: Curves.fastOutSlowIn),
        ),
      )..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            Navigator.pop(context);
          }
        });
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
          return Center(
            child: Column(
              children: <Widget>[
                Transform(
                  transform: Matrix4.translationValues(
                      _animation.value * width, 0.0, 0.0),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: 200,
                    height: 50,
                    color: Colors.red,
                  ),
                ),
                Transform(
                  transform: Matrix4.translationValues(
                      _animation.value * width, 0.0, 0.0),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: 200,
                    height: 50,
                    color: Colors.red,
                  ),
                ),
                Transform(
                  transform: Matrix4.translationValues(
                      _lateAnimation.value * width, 0.0, 0.0),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: 200,
                    height: 50,
                    color: Colors.red,
                  ),
                ),
              ],
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
