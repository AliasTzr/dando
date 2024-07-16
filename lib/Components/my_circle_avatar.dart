import 'package:flutter/material.dart';
import 'package:projet0_strat/Data/controller.dart';

class MyCircleAvatar extends StatelessWidget {
  final String image;
  final bool isLeftSide;
  const MyCircleAvatar({super.key, required this.image, required this.isLeftSide});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: isLeftSide ? MediaQuery.of(context).size.width / 7.5 : null,
      right: isLeftSide ? null : MediaQuery.of(context).size.width / 7.5,
      child: CircleAvatar(
        radius: 26.5,
        backgroundColor: isLeftSide ? Controller.tealColor : Controller.redColor,
        child: CircleAvatar(
          radius: 24,
          backgroundColor: Controller.bgColor,
          child: Padding(
            padding: const EdgeInsets.all(5.5),
            child: Image.asset(
              "assets/$image",
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
