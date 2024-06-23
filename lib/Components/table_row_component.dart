import 'package:flutter/material.dart';
import 'package:projet0_strat/Controllers/controller.dart';
import 'package:projet0_strat/Components/my_text_style.dart';

class TableRowComponent extends StatelessWidget {
  final String textValue;
  final bool isSynthesis;
  final int? countMatch, column;
  const TableRowComponent({super.key, required this.textValue, this.countMatch, required this.isSynthesis, this.column});
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 500),
      height: Controller.height / 18,
      width: isSynthesis ? Controller.width * 2/5 : Controller.width * 4/25,
      color: countMatch == column && column != null ? Colors.teal.shade300 : Colors.white,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          constraints: const BoxConstraints(minWidth:1, minHeight: 1),
          child: Text(
            textValue,
            style: const MyStyle(fontFamily: 'roboto', color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
          ),
        )
      )
    );
  }
}
