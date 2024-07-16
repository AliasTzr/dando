import 'package:flutter/material.dart';
import 'package:projet0_strat/Components/amount_shower.dart';
import 'package:projet0_strat/Data/controller.dart';

class ProfitShower extends StatelessWidget {
  final bool isGain;
  final String amount, label;
  const ProfitShower({super.key, required this.isGain, required this.amount, required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      padding: EdgeInsets.only(left: isGain ? MediaQuery.of(context).size.width * 0.019 : 0, right: isGain ? 0 : MediaQuery.of(context).size.width * 0.019),
      color: isGain ? Controller.tealColor: Controller.redColor,
      child: AmountShower(amount: amount, isBenefit: null, label: label,),
    );
  }
}