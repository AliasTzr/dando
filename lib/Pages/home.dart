import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:projet0_strat/Data/controller.dart';
import 'package:projet0_strat/Components/min_max_calculator.dart';
import 'package:projet0_strat/Data/methodes.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/Components/table_score_shower_component.dart';
import 'package:projet0_strat/Pages/pre_save_data.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  String scoreA = "", scoreB = "";
  bool caseASelected = true, caseBSelected = false;
  int countMatch = 0;
  List<String> scoresTeamA = List.filled(5, "");
  List<String> scoresTeamB = List.filled(5, "");
  String minScoreA = "", minScoreB = "", maxScoreA = "", maxScoreB = "", scoresTeamAForDatabase = "", scoresTeamBForDatabase = "";

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 26,),
        ScoreShower(scoresTeamA: scoresTeamA, scoresTeamB: scoresTeamB, countMatch: countMatch),
        SizedBox(height: MediaQuery.of(context).size.height / 20,),
        MinMaxCalculator(scoresA: scoresTeamA, scoresB: scoresTeamB),
        SizedBox(height: MediaQuery.of(context).size.height / 23,),
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 3 / 4,
              height: MediaQuery.of(context).size.height / 2.95,
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 33),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 12,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              caseASelected = true;
                              caseBSelected = false;
                            });
                          },
                          child: textFieldSelector(score: scoreA, placeHolderValue: "Score A", caseSelected: caseASelected),
                        ),
                        const SizedBox(width: 8,),
                        InkWell(
                          onTap: (){
                            setState(() {
                              caseASelected = false;
                              caseBSelected = true;
                            });
                          },
                          child: textFieldSelector(score: scoreB, placeHolderValue: "Score B", caseSelected: caseBSelected),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      calculatorButton(textValue: "1", numberSide: true, context),
                      SizedBox(width: MediaQuery.of(context).size.width / 25,),
                      calculatorButton(textValue: "2", numberSide: true, context),
                      SizedBox(width: MediaQuery.of(context).size.width / 25,),
                      calculatorButton(textValue: "3", numberSide: true, context),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 50,),
                  Row(
                    children: [
                      calculatorButton(textValue: "4", numberSide: true, context),
                      SizedBox(width: MediaQuery.of(context).size.width / 25,),
                      calculatorButton(textValue: "5", numberSide: true, context),
                      SizedBox(width: MediaQuery.of(context).size.width / 25,),
                      calculatorButton(textValue: "6", numberSide: true, context),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 50,),
                  Row(
                    children: [
                      calculatorButton(textValue: "7", numberSide: true, context),
                      SizedBox(width: MediaQuery.of(context).size.width / 25,),
                      calculatorButton(textValue: "8", numberSide: true, context),
                      SizedBox(width: MediaQuery.of(context).size.width / 25,),
                      calculatorButton(textValue: "9", numberSide: true, context),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 50,),
                  Row(
                    children: [
                      calculatorButton(textValue: "0", numberSide: true, context),
                      SizedBox(width: MediaQuery.of(context).size.width / 25,),
                      calculatorButton(textValue: "Match suivant", numberSide: true, context),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 4,
              height: MediaQuery.of(context).size.height / 2.95,
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.width / 24, right: MediaQuery.of(context).size.width / 33),
              child: Column(
                children: [
                  calculatorButton(textValue: "Supp.", numberSide: false, context),
                  SizedBox(height: MediaQuery.of(context).size.height / 52,),
                  calculatorButton(textValue: "Vider", numberSide: false, context),
                  SizedBox(height: MediaQuery.of(context).size.height / 52,),
                  calculatorButton(textValue: "Sauv.", numberSide: false, context),
                  SizedBox(height: MediaQuery.of(context).size.height / 52,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.height * (1 / 11 + 1 / 50),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Controller.tealColor),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                        ),
                        onPressed: (){
                          setState(() {
                            if(countMatch != 0){
                              scoreA  = scoresTeamA[countMatch - 1];
                              scoreB =  scoresTeamB[countMatch - 1];
                              countMatch--;
                            }
                          });
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Match",
                                style: MyStyle(fontFamily: 'acme', color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Préc.",
                                style: MyStyle(fontFamily: 'acme', color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
  Widget calculatorButton(BuildContext context, {required String textValue, bool? numberSide}) => SizedBox(
    width: numberSide! ? textValue == "Match suivant" ? (MediaQuery.of(context).size.width * (1 / 2.475 + 1/25) ) : MediaQuery.of(context).size.width / 4.95 : MediaQuery.of(context).size.width / 4,
    height: MediaQuery.of(context).size.height / 22,
    child: ElevatedButton(
        style: ButtonStyle(
            elevation: WidgetStateProperty.all(numberSide && textValue != "Match suivant"  ? 5 : 2),
            backgroundColor: WidgetStateProperty.all(textValue == "Match suivant" ? Colors.teal : Colors.white),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
        ),
        onPressed: () async {
          String formattedScoreA = "";
          String formattedScoreB = "";
          setState(() {
            if(isNumeric(textValue)){
              if(caseASelected){
                scoreA += textValue;
              }else{
                scoreB += textValue;
              }
            }
            else if(textValue == "Supp."){
              if(caseASelected && scoreA.isNotEmpty){
                scoreA = scoreA.substring(0, scoreA.length-1);
              }else if(caseBSelected && scoreB.isNotEmpty){
                scoreB = scoreB.substring(0, scoreB.length-1);
              }
            }
            else if(textValue == "Vider"){
              scoreA = "";
              scoreB = "";
              caseBSelected = false;
              caseASelected = true;
              scoresTeamA.fillRange(0, 5, "");
              scoresTeamB.fillRange(0, 5, "");
              countMatch = 0;
              scoresTeamBForDatabase = '';
              scoresTeamAForDatabase = '';
            }
            else if(textValue == "Match suivant" && countMatch < 5 && scoreA.isNotEmpty && scoreB.isNotEmpty){
              formattedScoreA = int.parse(scoreA).toString();
              formattedScoreB = int.parse(scoreB).toString();
              scoresTeamA[countMatch] = formattedScoreA;
              scoresTeamB[countMatch] = formattedScoreB;
              scoresTeamAForDatabase = convertListToString(scoresList: scoresTeamA);
              scoresTeamBForDatabase = convertListToString(scoresList: scoresTeamB);
              if(countMatch <= 3){
                scoreA = scoresTeamA[countMatch  + 1];
                scoreB = scoresTeamB[countMatch  + 1];
              } else{
                scoreA = '';
                scoreB = '';
              }
              caseASelected = true;
              caseBSelected = false;
              countMatch += 1;
              //<Home>
            }
          });
          if(textValue == "Sauv.") {
            if (context.mounted) {
              if(scoresTeamA[3].isNotEmpty){
                bool? saveSuccess = await showDialog(
                  context: context,
                  builder: (_) => PreSaveData(scoresTeamA: scoresTeamAForDatabase, scoresTeamB: scoresTeamBForDatabase,),
                  barrierDismissible: false,
                );
                if(saveSuccess != null && saveSuccess && context.mounted){
                  snackResult("Sauvegarde réussi.", context, success: true);
                }
              } else {
                snackResult("Sauvegarde possible à partir de 4 matchs", context, success: false);
              }
            }
          }
        },
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
          textValue,
          style: MyStyle(fontFamily: 'acme', color: textValue == "Match suivant" ? Colors.white : Colors.teal, fontWeight: FontWeight.w600, fontSize: numberSide && textValue != "Match suivant" ? 20: 14,)
          //fontSize:  color:
        ),
      )
    ),
  );
  Widget textFieldSelector({required String score, required String placeHolderValue, required bool caseSelected}) => AnimatedContainer(
    duration: const Duration(milliseconds: 500),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    width: MediaQuery.of(context).size.width / 3,
    height: MediaQuery.of(context).size.height / 17,
    decoration: BoxDecoration(
      color: caseSelected ? Colors.teal : Colors.black12,
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        score.isEmpty ? placeHolderValue : score,
        style: MyStyle(fontFamily: 'acme', color: score.isEmpty ? Colors.black54 : Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
      ),
    ),
  );
  String calculate(String score1, String score2){
    try{
      String result;
      var exp = Parser().parse("$score1 + $score2");
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      result = evaluation.toString().replaceAll(".0", "");
      return result;
    }catch(e){
      return "";
    }
  }
}