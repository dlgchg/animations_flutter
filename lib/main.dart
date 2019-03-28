import 'package:flutter/material.dart';
import 'ui/easing.dart';
import 'ui/offset.dart';
import 'ui/parent.dart';
import 'ui/trans.dart';
import 'ui/value.dart';
import 'ui/mask.dart';
import 'ui/spring.dart';
import 'ac/ac.dart';
import 'curves_d.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Main(),
    );
  }
}

class Main extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      EasingAnimation(),
      OffsetAnimation(),
      ParentAnimation(),
      TransAnimation(),
      ValueAnimation(),
      SpringAnimation(),
      MaskAnimation(),
      AnimatedC(),
      CurvesDemo(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Animations'),
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

