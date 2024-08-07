import 'package:flutter/material.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/Data/controller.dart';

class TableHeaderComponent extends StatelessWidget {
   final String? textValue;
  final bool positionTop;
  const TableHeaderComponent({super.key, required this.textValue, required this.positionTop});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: positionTop ? MediaQuery.of(context).size.height / 27 : MediaQuery.of(context).size.height / 18,
      color: Controller.blackColor,
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
