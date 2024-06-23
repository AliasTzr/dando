import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projet0_strat/Components/my_text_style.dart';

class MyLine extends StatelessWidget {
  final String name, value;
  MyLine({super.key, required this.name, required this.value});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: const MyStyle(fontFamily: 'quicksand', color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 16),
        ),
        Container(
          width: Get.width / 2,
          alignment: Alignment.centerRight,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: MyStyle(fontFamily: 'quicksand', color: name == "Statut" && value == "Libre" ? Colors.green.shade600: name == "Statut" ? Colors.red.shade700 : Colors.black, fontWeight: FontWeight.w800, fontSize: 15),
            ),
          ),
        )
      ],
    );
  }
}
