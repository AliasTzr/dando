import 'package:flutter/material.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/Data/controller.dart';

class ButtonHeader extends StatelessWidget {
  final String title;
  final Color color;
  const ButtonHeader({super.key, required this.title, required this.color});
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color:  color,
          borderRadius: BorderRadius.circular(7)
        ),
        child: Text(
          title,
          style: const MyStyle(fontFamily: 'acme', color: Controller.blackColor, fontWeight: FontWeight.w900, fontSize: 15),
        )
    );
  }
}
