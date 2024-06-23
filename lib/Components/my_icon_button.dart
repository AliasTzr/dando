import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ignore: must_be_immutable
class MyIconButton extends StatelessWidget {
  final IconData iconData;
  bool? isLeading;
  Color? color;
  void Function()? function;
  MyIconButton({super.key, required this.iconData, required this.isLeading, this.color = Colors.black, this.function});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        iconData,
      color: color,
    ),
    onPressed: isLeading! ? (){
      context.pop();
    } : (){
      function?.call();
    },
    splashRadius: 20
    );
  }
}