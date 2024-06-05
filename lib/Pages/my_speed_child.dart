import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class MySpeedDialChild extends SpeedDialChild {
  final IconData iconData;
  final Function function;
  final int color;
  MySpeedDialChild({super.key, required this.iconData, required this.function, required this.color}) : super(
    elevation: 0,
    backgroundColor: Color(color),
    child: Icon(iconData, color: Colors.white, size: 20,),
    onTap: (){
      function();
    }
  );
}