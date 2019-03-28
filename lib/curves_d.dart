import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/*
 * @Date: 2019-03-28 17:01 
 * @Description TODO
 */

class CurvesDemo extends StatefulWidget {
  @override
  _CurvesDemoState createState() => _CurvesDemoState();
}

class _CurvesDemoState extends State<CurvesDemo> with TickerProviderStateMixin {
  AnimationController controller;
  List<String> list = [
    'easeAnimation',
    'easeInAnimation',
    'easeInToLinearAnimation',
    'easeInSineAnimation',
    'easeInQuadAnimation',
    'easeInCubicAnimation',
    'easeInQuartAnimation',
    'easeInQuintAnimation',
    'easeInExpoAnimation',
    'easeInCricAnimation',
    'easeInBackAnimation',
    'easeOutAnimation',
    'linearToEaseOutAnimation',
    'easeOutSineAnimation',
    'easeOutQuadAnimation',
    'easeOutCubicAnimation',
    'easeOutQuintAnimation',
    'easeOutQuartAnimation',
    'easeOutExpoAnimation',
    'easeOutCircAnimation',
    'easeOutBackAnimation',
    'easeInOutAnimation',
    'easeInOutQuadAnimation',
    'easeInOutSineAnimation',
    'easeInOutCubicAnimation',
    'easeInOutQuartAnimation',
    'easeInOutQuintAnimation',
    'easeInOutExpoAnimation',
    'easeInOutCircAnimation',
    'easeInOutBackAnimation',
    'fastOutSlowInAnimation',
    'fastLinearToSlowEaseInAnimation',
  ];
  List<Cubic> cubics = [
    Curves.easeIn,
    Curves.easeInToLinear,
    Curves.easeInSine,
    Curves.easeInQuad,
    Curves.easeInCubic,
    Curves.easeInQuart,
    Curves.easeInQuint,
    Curves.easeInExpo,
    Curves.easeInCirc,
    Curves.easeInBack,
    Curves.easeOut,
    Curves.linearToEaseOut,
    Curves.easeOutSine,
    Curves.easeOutQuad,
    Curves.easeOutCubic,
    Curves.easeOutQuint,
    Curves.easeOutQuart,
    Curves.easeOutExpo,
    Curves.easeOutCirc,
    Curves.easeOutBack,
    Curves.easeInOut,
    Curves.easeInOutQuad,
    Curves.easeInOutSine,
    Curves.easeInOutCubic,
    Curves.easeInOutQuart,
    Curves.easeInOutQuint,
    Curves.easeInOutExpo,
    Curves.easeInOutCirc,
    Curves.easeInOutBack,
    Curves.fastOutSlowIn,
    Curves.fastLinearToSlowEaseIn
  ];

  List<Animation> animations = [];

  bool end = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    for (var i = 0; i < cubics.length; i++) {
      Animation animation = Tween(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: cubics[i],
        ),
      )..addStatusListener(_handler);
      animations.add(animation);
    }
  }


  _handler(status) {
    if (status == AnimationStatus.completed) {
      animations.map((animation) {
        animation.removeStatusListener(_handler);
      });
      animations.clear();
      controller.reset();
      for (var i = 0; i < cubics.length; i++) {
        Animation animation = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: cubics[i],
          ),
        )..addStatusListener((status){
          if(status == AnimationStatus.completed) {
            animations.map((animation) {
              animation.removeStatusListener(_handler);
            });
            animations.clear();
            controller.reset();
            _init();
            controller.forward();
          }
        });
        animations.add(animation);
      }
      end = !end;
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    controller.forward();
    return Scaffold(
      appBar: AppBar(
        title: Text('Curves Type Demo'),
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return ListView.builder(
            itemBuilder: (context, i) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Transform(
                      transform: Matrix4.translationValues(
                        animations[i].value * width,
                        0.0,
                        0.0,
                      ),
                      child: Container(
                        width: 50.0,
                        height: 50.0,
                        color: Colors.black12,
                      ),
                    ),
                    Text(list[i].toString()),
                  ],
                ),
              );
            },
            itemCount: animations.length,
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
