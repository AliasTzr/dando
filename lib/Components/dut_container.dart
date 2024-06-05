import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DutContainer extends AnimatedContainer {
  bool isActive;
  DutContainer({super.key, required this.isActive}) : super(
    duration: const Duration(milliseconds: 700),
    curve: Curves.easeIn,
    width: 10,
    height: 10,
    margin: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: isActive ? Colors.teal : Colors.black38,
      borderRadius: BorderRadius.circular(100)
    )
  );

}