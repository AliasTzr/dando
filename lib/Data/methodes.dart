import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/Controllers/controller.dart';

final Controller controller = Get.put(Controller());

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

String insertNewScore(String scoresList, String newScore){
  List<String> myArray = scoresList.split(" ");
  for (int i = myArray.length - 1; i > 0; i--) {
    myArray[i] = myArray[i - 1];
  }
  myArray[0] = newScore;
  return convertListToString(scoresList: myArray);
}

String convertListToString({required List scoresList}){
  String score = "";
  for(String scoresElement in scoresList){
    score += "$scoresElement ";
  }
  return score.replaceFirst(" ", '', score.lastIndexOf(" "));
}

void snackResult(String message, {bool success = true, bool bottomPosition = true}) {
  Get.snackbar(
      "", "",
      titleText: SizedBox(
        width: Get.width,
        child: Text(
          success ? "Opération réussie" : "Attention !!!",
          textAlign: TextAlign.center,
          style: MyStyle(fontFamily: controller.oswaldFamily, color: success ? controller.blackColor : controller.redColor, fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 2),
        ),
      ),
      messageText: SizedBox(
        width: Get.width,
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: MyStyle(fontFamily: controller.poppinsFamily, color: controller.blackColor, fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
      backgroundColor:success ? Colors.tealAccent.shade400 : controller.greyColor,
      snackPosition: bottomPosition ? SnackPosition.BOTTOM : SnackPosition.TOP,
      duration: const Duration(seconds: 5),
  );
}

List<String> listFilled(List<String> scores){
  List<String> listFilled = [];
  if(scores.isNotEmpty){
    for(int i = 0; i< scores.length; i++){
      if(scores[i] != ''){
        listFilled.add(scores[i]);
      }
    }
  }
  return listFilled;
}

String formatTime(TimeOfDay time) {
  DateTime now = DateTime.now();
  DateTime dateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
  String formattedTime = DateFormat('HH:mm').format(dateTime);
  return formattedTime;
}
Widget formField(TextEditingController controllerP, String hint, bool isForUpdating){
  return Container(
    width: Get.width * 3.3/5,
    decoration: BoxDecoration(
      color: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: TextField(
      controller: controllerP,
      maxLines: 1,
      cursorColor: Colors.black,
      keyboardType: isForUpdating ? TextInputType.number : TextInputType.text,
      style: MyStyle(fontFamily: controller.poppinsFamily, color: controller.blackColor, fontWeight: FontWeight.w600, fontSize: 14),
      decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(13)
      ),
    ),
  );
}