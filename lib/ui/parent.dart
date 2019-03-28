import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/*
 * @Date: 2019-03-28 09:30 
 * @Description TODO
 */

class ParentAnimation extends StatefulWidget {
  @override
  _ParentAnimationState createState() => _ParentAnimationState();
}

class _ParentAnimationState extends State<ParentAnimation>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation, _growAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _growAnimation = Tween(begin: 10.0, end: 100.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _animation = Tween(begin: -0.25, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
        if (status == AnimationStatus.dismissed) {
          Navigator.pop(context);
        }
      });
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Transform(
                  transform: Matrix4.translationValues(
                      _animation.value * width, 0.0, 0.0),
                  child: Center(
                      child: Container(
                        height: _growAnimation.value,
                        width: _growAnimation.value * 2,
                        color: Colors.black12,
                      ))),
              Transform(
                transform: Matrix4.translationValues(
                  _animation.value * width,
                  0.0,
                  0.0,
                ),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Container(
                      width: 200.0,
                      height: 100.0,
                      color: Colors.black12,
                    ),
                  ),
                ),
              )
            ],
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

/*
* import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/*
 * @Date: 2019-03-28 09:30
 * @Description TODO
 */

class ParentAnimation extends StatefulWidget {
  @override
  _ParentAnimationState createState() => _ParentAnimationState();
}

class _ParentAnimationState extends State<ParentAnimation>
    with TickerProviderStateMixin {
  Animation growingAnimation;
  Animation animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    growingAnimation = Tween(begin: 10.0, end: 100.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
    animation = Tween(begin: -0.25, end: 0.0).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    ))
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
    final double width = MediaQuery.of(context).size.width;
    controller.forward();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.toString()),
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Transform(
                  transform: Matrix4.translationValues(
                      animation.value * width, 0.0, 0.0),
                  child: Center(
                      child: Container(
                    height: growingAnimation.value,
                    width: growingAnimation.value * 2,
                    color: Colors.black12,
                  ))),
              Transform(
                transform: Matrix4.translationValues(
                  animation.value * width,
                  0.0,
                  0.0,
                ),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Container(
                      width: 200.0,
                      height: 100.0,
                      color: Colors.black12,
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

* */
