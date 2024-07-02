import 'package:flutter/material.dart';
import 'package:projet0_strat/Data/methodes.dart';
import 'package:projet0_strat/Components/table_header_component.dart';
import 'package:projet0_strat/Components/table_row_component.dart';

class ScoreShower extends StatelessWidget {
  final List<String> scoresTeamA, scoresTeamB;
  final String? nameTeamA, nameTeamB;
  final int? countMatch;
  const ScoreShower({super.key, required this.scoresTeamA, required this.scoresTeamB, this.countMatch, this.nameTeamA, this.nameTeamB});
  @override
  Widget build(BuildContext context) {
    return Table(
      border: const TableBorder(
          verticalInside: BorderSide(color: Colors.black12, width: 2),
          horizontalInside: BorderSide(),
          top: BorderSide(),
          bottom: BorderSide()
      ),
      columnWidths: <int, TableColumnWidth>{
        0: FixedColumnWidth(MediaQuery.of(context).size.width / 5),
      },
      children: [
        TableRow(
            children: [
              TableHeaderComponent(textValue: nameTeamA ?? "Équipe A", positionTop: false),
              TableRowComponent(textValue: scoresTeamA[0], countMatch: countMatch, column: 0, isSynthesis: false),
              TableRowComponent(textValue: scoresTeamA[1], countMatch: countMatch, column: 1, isSynthesis: false),
              TableRowComponent(textValue: scoresTeamA[2], countMatch: countMatch, column: 2, isSynthesis: false),
              TableRowComponent(textValue: scoresTeamA[3], countMatch: countMatch, column: 3, isSynthesis: false),
              TableRowComponent(textValue: scoresTeamA[4], countMatch: countMatch, column: 4, isSynthesis: false),
            ]
        ),
        TableRow(
            children: [
              TableHeaderComponent(textValue: nameTeamB ?? "Équipe B", positionTop: false),
              TableRowComponent(textValue: scoresTeamB[0], countMatch: countMatch, column: 0, isSynthesis: false),
              TableRowComponent(textValue: scoresTeamB[1], countMatch: countMatch, column: 1, isSynthesis: false),
              TableRowComponent(textValue: scoresTeamB[2], countMatch: countMatch, column: 2, isSynthesis: false),
              TableRowComponent(textValue: scoresTeamB[3], countMatch: countMatch, column: 3, isSynthesis: false),
              TableRowComponent(textValue: scoresTeamB[4], countMatch: countMatch, column: 4, isSynthesis: false),
            ]
        ),
        TableRow(
            children: [
              const TableHeaderComponent(textValue: "Total", positionTop: false),
              TableRowComponent(textValue: calculate(scoresTeamA[0], scoresTeamB[0]), countMatch: countMatch, column: 0, isSynthesis: false),
              TableRowComponent(textValue: calculate(scoresTeamA[1], scoresTeamB[1]), countMatch: countMatch, column: 1, isSynthesis: false),
              TableRowComponent(textValue: calculate(scoresTeamA[2], scoresTeamB[2]), countMatch: countMatch, column: 2, isSynthesis: false),
              TableRowComponent(textValue: calculate(scoresTeamA[3], scoresTeamB[3]), countMatch: countMatch, column: 3, isSynthesis: false),
              TableRowComponent(textValue: calculate(scoresTeamA[4], scoresTeamB[4]), countMatch: countMatch, column: 4, isSynthesis: false)
            ]
        )
      ],
    );
  }
}
