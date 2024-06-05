import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projet0_strat/Components/my_text_style.dart';

class TextContainer extends Container {
  final String data;
  final bool isGreyBG;
  final bool? isForGambler;
  TextContainer({super.key, required this.data, required this.isGreyBG, this.isForGambler = false}) : super(
    height: isForGambler! ? Get.height / 3.6 : 70,
    width: Get.width,
    padding: const EdgeInsets.all(15),
    margin: EdgeInsets.zero,
    alignment: Alignment.center,
    color:isGreyBG ? const Color(0xFFDDDBE6) : Colors.transparent,
    child: Text(
      data,
      textAlign: TextAlign.center,
      style: const  MyStyle(
        fontFamily: 'quicksand',
        color:  Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 15,
        letterSpacing: 2
      ),
    ),
  );
}