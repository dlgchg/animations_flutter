import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/*
 * @Date: 2019-03-28 14:23 
 * @Description TODO
 */

class Charts extends StatefulWidget {
  @override
  _ChartsState createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  var height = 100.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          height: 400,
          alignment: AlignmentDirectional.bottomStart,
          child: InkWell(
            onTap: (){
              setState(() {
                height = 320;
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  width: 40.0,
                  height: height - 40,
                  color: Colors.greenAccent,
                ),
                AnimatedContainer(
                  margin: EdgeInsets.only(left: 10.0),
                  duration: Duration(seconds: 2),
                  width: 40.0,
                  height: height - 10,
                  color: Colors.yellow,
                ),
                AnimatedContainer(
                  margin: EdgeInsets.only(left: 10.0),
                  duration: Duration(seconds: 3),
                  width: 40.0,
                  height: height - 60,
                  color: Colors.red,
                ),
                AnimatedContainer(
                  margin: EdgeInsets.only(left: 10.0),
                  duration: Duration(seconds: 2),
                  width: 40.0,
                  height: height - 50,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
