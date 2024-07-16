import 'package:flutter/material.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/Data/controller.dart';

class LevelManagementButton extends StatelessWidget {
  final bool start;
  final String text;
  const LevelManagementButton({super.key, required this.start, required this.text});
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: start ? MediaQuery.of(context).size.width / 2.65 : MediaQuery.of(context).size.width  * (5 / 12),
      alignment: start ? Alignment.center : text.contains("encer") ? Alignment.centerLeft : Alignment.centerRight,
      decoration: BoxDecoration(
        color: text.contains("Perdu") ?Colors.red.shade600 : Colors.teal.shade300,
        borderRadius: start ? BorderRadius.circular(10) : null
      ),
      child: Text(
        text.toUpperCase(),
        style: const MyStyle(fontFamily: Controller.poppinsFamily, color: Controller.blackColor, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}