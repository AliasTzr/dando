import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projet0_strat/Components/my_text_style.dart';


// ignore: must_be_immutable
class CalculatorButtons extends StatefulWidget {
  int countMatch;
  final List<String> scoresTeamA, scoresTeamB;
  final Function(List<String>) refreshScoresTeamA;
  final Function(List<String>) refreshScoresTeamB;
  final VoidCallback manageButton;
  final Function(int) refreshCountMatch;
  CalculatorButtons({super.key, required this.countMatch, required this.scoresTeamB, required this.scoresTeamA, required this.refreshScoresTeamA, required this.refreshScoresTeamB, required this.refreshCountMatch, required this.manageButton});

  @override
  State<CalculatorButtons> createState() => _CalculatorButtonsState();
}

class _CalculatorButtonsState extends State<CalculatorButtons> {
  String scoreA = '', scoreB = '', scoresTeamBForDatabase = '', scoresTeamAForDatabase = '';
  bool caseASelected = true, caseBSelected = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: Get.width * 3 / 4,
          height: Get.height / 2.95,
          padding: EdgeInsets.symmetric(horizontal: Get.width / 33),
          child: Column(
            children: [
              SizedBox(
                width: Get.width,
                height: Get.height / 12,
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
                  calculatorButton(textValue: "1", numberSide: true, onButtonPressed: widget.manageButton),
                  SizedBox(width: Get.width / 25,),
                  calculatorButton(textValue: "2", numberSide: true, onButtonPressed: widget.manageButton),
                  SizedBox(width: Get.width / 25,),
                  calculatorButton(textValue: "3", numberSide: true, onButtonPressed: widget.manageButton),
                ],
              ),
              SizedBox(height: Get.height / 50,),
              Row(
                children: [
                  calculatorButton(textValue: "4", numberSide: true, onButtonPressed: widget.manageButton),
                  SizedBox(width: Get.width / 25,),
                  calculatorButton(textValue: "5", numberSide: true, onButtonPressed: widget.manageButton),
                  SizedBox(width: Get.width / 25,),
                  calculatorButton(textValue: "6", numberSide: true, onButtonPressed: widget.manageButton),
                ],
              ),
              SizedBox(height: Get.height / 50,),
              Row(
                children: [
                  calculatorButton(textValue: "7", numberSide: true, onButtonPressed: widget.manageButton),
                  SizedBox(width: Get.width / 25,),
                  calculatorButton(textValue: "8", numberSide: true, onButtonPressed: widget.manageButton),
                  SizedBox(width: Get.width / 25,),
                  calculatorButton(textValue: "9", numberSide: true, onButtonPressed: widget.manageButton),
                ],
              ),
              SizedBox(height: Get.height / 50,),
              Row(
                children: [
                  calculatorButton(textValue: "0", numberSide: true, onButtonPressed: widget.manageButton),
                  SizedBox(width: Get.width / 25,),
                  calculatorButton(textValue: "Match suivant", numberSide: true, onButtonPressed: widget.manageButton),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: Get.width / 4,
          height: Get.height / 2.95,
          padding: EdgeInsets.only(top: Get.width / 24, right: Get.width / 33),
          child: Column(
            children: [
              calculatorButton(textValue: "Supp.", numberSide: false, onButtonPressed: widget.manageButton),
              SizedBox(height: Get.height / 52,),
              calculatorButton(textValue: "Vider", numberSide: false, onButtonPressed: widget.manageButton),
              SizedBox(height: Get.height / 52,),
              calculatorButton(textValue: "Sauv.", numberSide: false, onButtonPressed: widget.manageButton),
              SizedBox(height: Get.height / 52,),
              SizedBox(
                width: Get.width / 4,
                height: Get.height * (1 / 11 + 1 / 50),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.teal),
                    ),
                    onPressed: (){
                      setState(() {
                        if(widget.countMatch != 0){
                          widget.refreshScoresTeamA(widget.scoresTeamA);
                          widget.refreshScoresTeamB(widget.scoresTeamB);
                          widget.refreshCountMatch(widget.countMatch);
                          scoreA  = widget.scoresTeamA[widget.countMatch - 1];
                          scoreB =  widget.scoresTeamB[widget.countMatch - 1];
                          widget.countMatch--;
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
                            style: MyStyle(fontFamily: "acme", color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Préc.",
                            style: MyStyle(fontFamily: "acme", color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
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
    );
  }
  Widget calculatorButton({required String textValue, bool? numberSide, required VoidCallback onButtonPressed}) => SizedBox(
    width: numberSide! ? textValue == "Match suivant" ? (Get.width * (1 / 2.475 + 1/25) ) : Get.width / 4.95 : Get.width / 4,
    height: Get.height / 22,
    child: TextButton(
        style: ButtonStyle(
            elevation: WidgetStateProperty.all(numberSide && textValue != "Match suivant"  ? 0 : 3),
            backgroundColor: WidgetStateProperty.all(textValue == "Match suivant" ? Colors.teal : Colors.white)
        ),
        onPressed: onButtonPressed,
        child: Text(
          textValue,
          style: MyStyle(fontFamily: "poppins", color: textValue == "Match suivant" ? Colors.white : Colors.teal, fontWeight: FontWeight.w500, fontSize: numberSide && textValue != "Match suivant" ? 20: 14),
        )
    ),
  );

  Widget textFieldSelector({required String score, required String placeHolderValue, required bool caseSelected}) => AnimatedContainer(
    duration: const Duration(seconds: 1),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    width: Get.width / 3,
    height: Get.height / 17,
    decoration: BoxDecoration(
      color: caseSelected ? Colors.teal : Colors.black12,
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        score.isEmpty ? placeHolderValue : score,
        style: MyStyle(fontFamily: "poppins", color: score.isEmpty ? Colors.black54 : Colors.black, fontWeight: FontWeight.bold, fontSize: 17)
      ),
    ),
  );
}
