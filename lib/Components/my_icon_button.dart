import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyIconButton extends IconButton {
  MyIconButton({super.key, required IconData iconData, required bool? isLeading, Color color = Colors.black, void Function()? function}): super(
    icon: Icon(
        iconData,
      color: color,
    ),
    onPressed: isLeading! ? (){
      Get.back();
    } : (){
      function?.call();
    },
    splashRadius: 20
  );
}