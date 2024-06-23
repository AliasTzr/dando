import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:projet0_strat/Controllers/controller.dart';
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
        SizedBox(height: Controller.height / 26,),
        ScoreShower(scoresTeamA: scoresTeamA, scoresTeamB: scoresTeamB, countMatch: countMatch),
        SizedBox(height: Controller.height / 20,),
        MinMaxCalculator(scoresA: scoresTeamA, scoresB: scoresTeamB),
        SizedBox(height: Controller.height / 23,),
        Row(
          children: [
            Container(
              width: Controller.width * 3 / 4,
              height: Controller.height / 2.95,
              padding: EdgeInsets.symmetric(horizontal: Controller.width / 33),
              child: Column(
                children: [
                  SizedBox(
                    width: Controller.width,
                    height: Controller.height / 12,
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
                      calculatorButton(textValue: "1", numberSide: true),
                      SizedBox(width: Controller.width / 25,),
                      calculatorButton(textValue: "2", numberSide: true),
                      SizedBox(width: Controller.width / 25,),
                      calculatorButton(textValue: "3", numberSide: true),
                    ],
                  ),
                  SizedBox(height: Controller.height / 50,),
                  Row(
                    children: [
                      calculatorButton(textValue: "4", numberSide: true),
                      SizedBox(width: Controller.width / 25,),
                      calculatorButton(textValue: "5", numberSide: true),
                      SizedBox(width: Controller.width / 25,),
                      calculatorButton(textValue: "6", numberSide: true),
                    ],
                  ),
                  SizedBox(height: Controller.height / 50,),
                  Row(
                    children: [
                      calculatorButton(textValue: "7", numberSide: true),
                      SizedBox(width: Controller.width / 25,),
                      calculatorButton(textValue: "8", numberSide: true),
                      SizedBox(width: Controller.width / 25,),
                      calculatorButton(textValue: "9", numberSide: true),
                    ],
                  ),
                  SizedBox(height: Controller.height / 50,),
                  Row(
                    children: [
                      calculatorButton(textValue: "0", numberSide: true),
                      SizedBox(width: Controller.width / 25,),
                      calculatorButton(textValue: "Match suivant", numberSide: true),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: Controller.width / 4,
              height: Controller.height / 2.95,
              padding: EdgeInsets.only(top: Controller.width / 24, right: Controller.width / 33),
              child: Column(
                children: [
                  calculatorButton(textValue: "Supp.", numberSide: false),
                  SizedBox(height: Controller.height / 52,),
                  calculatorButton(textValue: "Vider", numberSide: false),
                  SizedBox(height: Controller.height / 52,),
                  calculatorButton(textValue: "Sauv.", numberSide: false),
                  SizedBox(height: Controller.height / 52,),
                  SizedBox(
                    width: Controller.width / 4,
                    height: Controller.height * (1 / 11 + 1 / 50),
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
  Widget calculatorButton({required String textValue, bool? numberSide}) => SizedBox(
    width: numberSide! ? textValue == "Match suivant" ? (Controller.width * (1 / 2.475 + 1/25) ) : Controller.width / 4.95 : Controller.width / 4,
    height: Controller.height / 22,
    child: ElevatedButton(
        style: ButtonStyle(
            elevation: WidgetStateProperty.all(numberSide && textValue != "Match suivant"  ? 5 : 2),
            backgroundColor: WidgetStateProperty.all(textValue == "Match suivant" ? Colors.teal : Colors.white),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
        ),
        onPressed: () async {
          int scoreAAsInt = 0;
          String formattedScoreA = "";
          int scoreBAsInt = 0;
          String formattedScoreB = "";
          setState(() {
            if(textValue.isNum){
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
              scoreAAsInt = int.parse(scoreA);
              formattedScoreA = scoreAAsInt.toString();
              scoreBAsInt = int.parse(scoreB);
              formattedScoreB = scoreBAsInt.toString();
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
            if(scoresTeamA[3].isNotEmpty){
              bool? saveSuccess = await Get.dialog(
                const PreSaveData(),
                transitionDuration: const Duration(milliseconds: 500),
                transitionCurve: Curves.easeIn,
                arguments: [scoresTeamAForDatabase, scoresTeamBForDatabase],
                barrierDismissible: false,
              );
              if(saveSuccess != null && saveSuccess){
                snackResult("Sauvegarde réussi.", success: true);
              }
            } else {
              snackResult("Sauvegarde possible à partir de 4 matchs", success: false);
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
    width: Controller.width / 3,
    height: Controller.height / 17,
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