import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/Data/controller.dart';
import 'package:projet0_strat/Models/prefs_data.dart';

// ignore: must_be_immutable
class AmountForStarting extends StatefulWidget {
  final TextEditingController? textEditingController;
  final bool isForAmount;
  final String? message;
  const AmountForStarting({super.key, this.textEditingController, required this.isForAmount, this.message});

  @override
  State<AmountForStarting> createState() => _AmountForStartingState();
}

class _AmountForStartingState extends State<AmountForStarting> {
  final PrefsData _prefsData = PrefsData();
  final FocusNode _focusNode = FocusNode();
  String _odds = "3";
  int _currentOdds = 1;
  @override
  void initState() {
    if (widget.textEditingController != null) {
      widget.textEditingController!.clear();
      _focusNode.requestFocus();
    }
    super.initState();
  }

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
              widget.isForAmount ? Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.11),
                child: TextField(
                  controller: widget.textEditingController,
                  maxLength: 5,
                  maxLines: 1,
                  minLines: 1,
                  focusNode: _focusNode,
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
                    "${widget.message}\nIl est recommandé de\nrecommencer !",
                    textAlign: TextAlign.center,
                    style: const MyStyle(fontFamily: Controller.poppinsFamily, color: Controller.blackColor, fontWeight: FontWeight.w400, fontSize: 17),
                  ),
              ),
              widget.isForAmount ? SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(3, (int index){
                    if (index == 0) {
                      return const Text(
                      "Cotes: ",
                      style: MyStyle(fontFamily: Controller.poppinsFamily, color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                    );
                    } else {
                      return CircleAvatar(
                        backgroundColor: _currentOdds == index ? Controller.tealColor : Controller.bgColor,
                        radius: 20,
                        child: IconButton(
                          color: Colors.black,
                          onPressed: _currentOdds != index ? (){
                            setState(() {
                              _currentOdds = index;
                              _odds = index == 1 ? "3": "5";
                            });
                          } : null, 
                          icon: Icon(MdiIcons.fromString("numeric${index == 1 ? "3" : "5"}CircleOutline"))
                        ),
                      );
                    }
                  }),
                ),
              ): const SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(2, (int index)=> TextButton(
                      onPressed: (){
                        if (widget.isForAmount) {
                          context.pop(index % 2 != 0 ? _odds : "null");
                        } else {
                          if (index % 2 != 0) {
                            _prefsData.setBoolData("start3", false);
                            _prefsData.setData("stake", "0");
                            _prefsData.setData("startingStake", "0");
                            _prefsData.setData("win", "0");
                            _prefsData.setData("lost", "0");
                            _prefsData.setData("level", "0");
                            _prefsData.setData("benef", "0");
                            _prefsData.setData("odds", "0");
                          }
                          context.pop(index % 2 != 0);
                        }
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