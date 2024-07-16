import 'package:flutter/material.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/Data/controller.dart';
import 'package:projet0_strat/Data/methodes.dart';

class AmountShower extends StatelessWidget {
  final String amount;
  final String label;
  final bool? isBenefit;
  const AmountShower({super.key, required this.amount, required this.label, required this.isBenefit});
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color:isBenefit == null ? Colors.transparent : isBenefit! ? Colors.teal.shade100 : Controller.bgColor,
        borderRadius: isBenefit != null  ? isBenefit! ? const BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)) : const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)) : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 2.88,
          height: MediaQuery.of(context).size.height / 20,
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 1, minHeight: 1),
              child: Text(
                amount != "0" ? addSpaces(amount) : label,
                style: const MyStyle(fontFamily: Controller.oswaldFamily, color:  Colors.black, fontWeight: FontWeight.w900, fontSize: 30),
              ),
            ),
          )
        ),
      ),
    );
  }
}
