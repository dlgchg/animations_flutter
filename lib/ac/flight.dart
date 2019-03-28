import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/*
 * @Date: 2019-03-28 14:36 
 * @Description TODO
 */

class Flight extends StatefulWidget {
  @override
  _FlightState createState() => _FlightState();
}

class _FlightState extends State<Flight> {
  var _alignment = Alignment.bottomCenter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AnimatedContainer(
        duration: Duration(seconds: 2),
        padding: EdgeInsets.all(10.0),
        alignment: _alignment,
        child: Container(
          child: Icon(
            Icons.airplanemode_active,
            size: 50.0,
            color: Colors.blueAccent,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            _alignment = Alignment.center;
          });
        },
        icon: Icon(Icons.airplanemode_active),
        label: Text('Flight'),
      ),
    );
  }
}
