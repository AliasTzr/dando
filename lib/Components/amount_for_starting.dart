import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/Data/controller.dart';
import 'package:projet0_strat/Models/prefs_data.dart';

class AmountForStarting extends StatelessWidget {
  final TextEditingController? textEditingController;
  final bool isForAmount;
  final String? message;
  AmountForStarting({super.key, this.textEditingController, required this.isForAmount, this.message});
  final PrefsData _prefsData = PrefsData();
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white30,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.23,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              isForAmount ? Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: MediaQuery.of(context).size.width * 0.11),
                child: TextField(
                  controller: textEditingController,
                  maxLength: 5,
                  maxLines: 1,
                  minLines: 1,
                  keyboardType: TextInputType.number,
                  style: const MyStyle(fontFamily: Controller.acmeFamily, color: Colors.black, fontWeight: FontWeight.w400, fontSize: 20),
                  decoration: const InputDecoration(
                    hintText: "Mise de départ. Ex: 1000",
                    contentPadding: EdgeInsets.zero,
                    hintStyle: MyStyle(fontFamily: Controller.acmeFamily, color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 17)
                  ),
                )
              ) : Padding(
                padding:  const EdgeInsets.all(10),
                child:  Text(
                    "${message ?? ""}\nIl est recommandé de\nrecommencer !",
                    textAlign: TextAlign.center,
                    style: const MyStyle(fontFamily: Controller.poppinsFamily, color: Controller.blackColor, fontWeight: FontWeight.w400, fontSize: 17),
                  ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 30, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(2, (int index)=> TextButton(
                      onPressed: (){
                        if (!isForAmount && index % 2 != 0) {
                          _prefsData.setBoolData("start3", false);
                          _prefsData.setData("stake", "0");
                          _prefsData.setData("startingStake", "0");
                          _prefsData.setData("win", "0");
                          _prefsData.setData("lost", "0");
                           _prefsData.setData("level", "0");
                          _prefsData.setData("benef", "0");
                        }
                        context.pop(index % 2 != 0);
                        
                      },
                      child: Text(
                        index % 2 == 0 ? "Annuler" : "Valider",
                        style: MyStyle(fontFamily: Controller.quicksandFamily, color: index % 2 == 0 ? Controller.redColor : Controller.tealColor, fontWeight: FontWeight.w600, fontSize: 16),
                      )
                    )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}