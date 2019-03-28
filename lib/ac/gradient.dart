import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/*
 * @Date: 2019-03-28 14:42 
 * @Description TODO
 */

class GradientP extends StatefulWidget {
  @override
  _GradientState createState() => _GradientState();
}

class _GradientState extends State<GradientP> {
  var top = FractionalOffset.topCenter;
  var bottom = FractionalOffset.bottomCenter;
  var list = [
    Colors.lightGreen,
    Colors.redAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: AnimatedContainer(
          height: 300.0,
          width: 300.0,
          duration: Duration(seconds: 1),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: top,
              end: bottom,
              colors: list,
              stops: [0.0, 1.0],
            ),
            color: Colors.lightGreen,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            top = FractionalOffset.bottomLeft;
            bottom = FractionalOffset.topRight;
            list = [Colors.blueAccent, Colors.yellowAccent];
          });
        },
        icon: Icon(Icons.update),
        label: Text("Transform"),
      ),
    );
  }
}
