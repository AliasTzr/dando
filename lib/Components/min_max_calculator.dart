import 'package:flutter/material.dart';
import 'package:projet0_strat/Components/table_header_component.dart';
import 'package:projet0_strat/Components/table_row_component.dart';
import 'package:projet0_strat/Controllers/controller.dart';

import '../Data/methodes.dart';

class MinMaxCalculator extends StatefulWidget {
  final List<String> scoresA, scoresB;
  final String? nameTeamA, nameTeamB;
  const MinMaxCalculator({super.key, required this.scoresA, required this.scoresB, this.nameTeamB, this.nameTeamA});

  @override
  State<MinMaxCalculator> createState() => _MinMaxCalculatorState();
}

class _MinMaxCalculatorState extends State<MinMaxCalculator> {
  String _minTeamA = '', _maxTeamA = '', _minTeamB = '', _maxTeamB = '';

  @override
  Widget build(BuildContext context) {
    calculateMinMax();
    return Table(
      border: const TableBorder(
          verticalInside: BorderSide(color: Colors.black12, width: 2),
          horizontalInside: BorderSide(),
          bottom: BorderSide()
      ),
      columnWidths: <int, TableColumnWidth>{
        0: FixedColumnWidth(MediaQuery.of(context).size.width / 5),
      },
      children: [
        TableRow(
            children: [
              SizedBox(height: Controller.height / 27,),
              TableHeaderComponent(textValue: "Score min", positionTop: true),
              TableHeaderComponent(textValue:  "Score max", positionTop: true)
            ]
        ),
        TableRow(
            children: [
              TableHeaderComponent(textValue:widget.nameTeamA ?? "Équipe A", positionTop: false),
              TableRowComponent(textValue: _minTeamA, isSynthesis: true),
              TableRowComponent(textValue: _maxTeamA, isSynthesis: true)
            ]
        ),
        TableRow(
            children: [
              TableHeaderComponent(textValue: widget.nameTeamB ?? "Équipe B", positionTop: false),
              TableRowComponent(textValue: _minTeamB, isSynthesis: true),
              TableRowComponent(textValue: _maxTeamB, isSynthesis: true)
            ]
        ),
        TableRow(
            children: [
              TableHeaderComponent(textValue: "Total", positionTop: false),
              TableRowComponent(textValue: calculate(_minTeamA, _minTeamB), isSynthesis: true),
              TableRowComponent(textValue: calculate(_maxTeamA, _maxTeamB), isSynthesis: true)
            ]
        )
      ],
    );
  }

  void calculateMinMax(){
    if(listFilled(widget.scoresA).isNotEmpty){
      _minTeamA = listFilled(widget.scoresA).reduce((value, element) => int.parse(value) < int.parse(element) ? value : element);
      _maxTeamA = listFilled(widget.scoresA).reduce((value, element) => int.parse(value) > int.parse(element) ? value : element);
      _minTeamB = listFilled(widget.scoresB).reduce((value, element) => int.parse(value) < int.parse(element) ? value : element);
      _maxTeamB = listFilled(widget.scoresB).reduce((value, element) => int.parse(value) > int.parse(element) ? value : element);

    } else{
      _minTeamA = '';
      _maxTeamA = '';
      _minTeamB = '';
      _maxTeamB = '';
    }
  }
}
