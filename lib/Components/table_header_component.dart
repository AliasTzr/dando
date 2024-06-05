import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projet0_strat/Controllers/controller.dart';
import 'package:projet0_strat/Components/my_text_style.dart';

class TableHeaderComponent extends StatelessWidget {
   final String? textValue;
  final bool positionTop;
   TableHeaderComponent({super.key, required this.textValue, required this.positionTop});
   final Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: positionTop ? controller.height / 27 : controller.height / 18,
      color: controller.blackColor,
      alignment: Alignment.center,
      child: FittedBox(
        child: Text(
          textValue!,
          style: const MyStyle(fontFamily: 'roboto', color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)
        ),
      ),
    );
  }
}
