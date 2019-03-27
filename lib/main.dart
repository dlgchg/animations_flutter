import 'package:flutter/material.dart';
import 'ui/easing.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  List<Widget> list = [
    EasingAnimation(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Animations'),
        ),
        body: ListView(
          children: list.map((page) {
            return ListTile(
              title: Text(page.toString()),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
