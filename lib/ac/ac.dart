import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'charts.dart';
import 'flight.dart';
import 'gradient.dart';

/*
 * @Date: 2019-03-28 14:21 
 * @Description TODO
 */

class AnimatedC extends StatefulWidget {
  @override
  _AnimatedCState createState() => _AnimatedCState();
}

class _AnimatedCState extends State<AnimatedC> {
  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      Charts(),
      Flight(),
      GradientP(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedContainer'),
      ),
      body: ListView(
        children: list.map((widget) {
          return ListTile(
            title: Text(widget.toString()),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => widget),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
