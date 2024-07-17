import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:projet0_strat/Components/amount_for_starting.dart';
import 'package:projet0_strat/Components/amount_shower.dart';
import 'package:projet0_strat/Components/level_management_button.dart';
import 'package:projet0_strat/Components/my_circle_avatar.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/Components/triple_to_x.dart';
import 'package:projet0_strat/Data/controller.dart';
import 'package:projet0_strat/Data/methodes.dart';
import 'package:projet0_strat/Models/prefs_data.dart';
import 'package:projet0_strat/Pages/profit_shower.dart';

class TripleToX extends StatefulWidget {
  const TripleToX({super.key});

  @override
  State<TripleToX> createState() => _TripleToXState();
}

class _TripleToXState extends State<TripleToX> {
  bool _pressed = false,_start = false;
  final TextEditingController _textEditingController = TextEditingController();
  final PrefsData _prefsData = PrefsData();
  String _stake = '', _betWin = '', _betLost = '', _level = '', _benefit = '', _startingStake = '', _odds = '';
  @override
  void initState() {
    super.initState();
    initialization();
  }
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _start ? IconButton(
                    iconSize: 30,
                    onPressed: dataReset,
                    icon: Icon(
                      MdiIcons.databaseRemove,
                    )) : const SizedBox.shrink(),
                InkWell(
                  onTap: () {
                    setState(() {
                      _pressed = !_pressed;
                    });
                  },
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor:
                        _pressed ? Colors.grey.shade300 : Colors.transparent,
                    child: Image.asset(
                      "assets/idee.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: MediaQuery.of(context).size.width,
            height: _pressed ? MediaQuery.of(context).size.height / 1.6 : 0,
            padding: const EdgeInsets.all(5),
            color: Controller.bgColor,
            child: TripleToXTips(),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 6.7,
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3.5,
                  height: MediaQuery.of(context).size.height / 24,
                  child: AmountShower(
                    amount: _stake,
                    isBenefit: false,
                    label: "Mise: 0",
                  ),
                ),
                Container(
                  height: (MediaQuery.of(context).size.height / 6.7) / 2.3,
                  margin: EdgeInsets.zero,
                  color: Controller.bgColor,
                  child: Stack(
                    children: [
                      Positioned(
                        left: MediaQuery.of(context).size.width / 4,
                        top: MediaQuery.of(context).size.height / 90,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height:
                              (MediaQuery.of(context).size.height / 6.7) / 3.5,
                          color: Colors.blue,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ProfitShower(isGain: true, amount: _betWin, label: 'Gains: 0',),
                              ProfitShower(isGain: false, amount: _betLost, label: 'Pertes: 0',)
                            ],
                          ),
                        ),
                      ),
                      const MyCircleAvatar(
                          image: "gains.png", isLeftSide: true),
                      const MyCircleAvatar(
                          image: "perte.png", isLeftSide: false)
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3.5,
                  height: MediaQuery.of(context).size.height / 24,
                  child: AmountShower(
                    amount: _benefit,
                    isBenefit: true,
                    label: 'Bénéfices: 0',
                  ),
                ),
              ],
            ),
          ),
          myText(context, "Palier: $_level"),
          myText(context, "Cote: $_odds"),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 12,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 4.5,
                right: MediaQuery.of(context).size.width / 12,
                left: MediaQuery.of(context).size.width / 12),
            child: InkWell(
              onTap: _start
                  ? null
                  : () async {
                      String? isDone = await showDialog(
                          context: context,
                          builder: (BuildContext context) => AmountForStarting(
                                textEditingController: _textEditingController,
                                isForAmount: true,
                                message: null,
                              ));
                      if (isDone != null && isDone != "null") {
                        String value = _textEditingController.text.trim().replaceAll(" ", "").replaceAll("-", '');
                        if (isNumeric(addSpaces(value).replaceAll(" ", '')) && int.parse(addSpaces(value).replaceAll(" ", '')) != 0) {
                          setState(() {
                            _stake = value;
                            _start = true;
                            _level = "1";
                            _odds = isDone;
                            _startingStake = value;
                          });
                          _prefsData.setData("stake", _stake);
                          _prefsData.setData("startingstake", _startingStake);
                          _prefsData.setBoolData("start3", _start);
                          _prefsData.setData("level", _level);
                          _prefsData.setData("odds", _odds);
                        } else {
                          if (context.mounted) snackResult("Valeur non prise en charge", context, success: false);
                        }
                      }
                    },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: _start
                          ? _level != "10" ? () {
                              setState(() {
                                _betWin = calculate(_betWin, calculateAmount(_stake, _odds));
                                _benefit = (int.parse(_betWin) - (int.parse(_stake) + int.parse(_betLost))).toString();
                                _betLost = "0";
                                if (_level != "1") {
                                  if (int.parse(_level) > int.parse(_odds)){
                                    _stake = _startingStake;
                                    _prefsData.setData("stake", _stake);
                                  }
                                  _level = "1";
                                  _prefsData.setData("level", _level);
                                }
                                _prefsData.setData("win", _betWin);
                                _prefsData.setData("benef", _benefit);
                                _prefsData.setData("lost", _betLost);
                              });
                            } : (){restart(context);}
                          : null,
                      child: LevelManagementButton(
                          start: _start, text: _start ? "Gagné" : " Comm")),
                  InkWell(
                    onTap: _start
                        ? _level != "10" ? () {
                            setState(() {
                              if (int.parse(_level) < 10) {
                                if (!int.parse(_benefit).isNegative && _benefit != "0") {_benefit = (int.parse(_benefit) - int.parse(_stake)).toString();} else {_benefit = "0";}
                                if (!int.parse(_betWin).isNegative && _betWin != "0") {_betWin = (int.parse(_betWin) - int.parse(_stake)).toString();} else {_betWin = "0";}
                                _level = calculate(_level, "1");
                                _betLost = calculate(_betLost, _stake);
                                if (_odds == "3") {
                                  switch (_level) {
                                    case "4" || "5":
                                      _stake =  calculateAmount(_startingStake, "3");
                                      break;
                                    case "6" || "7":
                                      if(_level == "6") restart(context, message: "Vous avez perdu 5 fois !");
                                       _stake =  calculateAmount(_startingStake, "9");
                                      break;
                                    case "8" || "9":
                                      _stake =  calculateAmount(_startingStake, "27");
                                      break;
                                    case "10":
                                      _stake =  calculateAmount(_startingStake, "81");
                                      break;
                                    default:
                                      break;
                                  }
                                }
                                if (_odds == "5") {
                                  switch (_level) {
                                    case "6" || "7" || "8":
                                      _stake = calculateAmount(_startingStake, "3");
                                      break;
                                    case "9" || "10":
                                      break;
                                    default:
                                  }
                                  if (_level == "6" || _level == "7" || _level == "8") {
                                    _stake =  (int.parse(_startingStake) * 3).toString();
                                  }
                                  if (_level == "9" || _level == "10") {
                                    if(_level == "9") restart(context, message: "Vous avez perdu 8 fois !");
                                    _stake =  (int.parse(_startingStake) * 9).toString();
                                  }
                                }
                                _prefsData.setData("lost", _betLost);
                                _prefsData.setData("level", _level);
                                _prefsData.setData("win", _betWin);
                                _prefsData.setData("stake", _stake);
                                _prefsData.setData("benef", _benefit);
                              } else {
                                _betLost = calculate(_betLost, _stake);
                                _prefsData.setData("lost", _betLost);
                                snackResult("Dernier Niveau atteint. Recommencez SVP !", context, success: false);
                              }
                            });
                          } : (){restart(context);}
                        : null,
                    child: LevelManagementButton(
                        start: _start, text: _start ? "Perdu" : "encer"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

void initialization() async {
    _start = await _prefsData.getBoolData("start3");
    _stake = await _prefsData.getData("stake");
    _startingStake = await _prefsData.getData("startingstake");
    _betWin = await _prefsData.getData("win");
    _betLost = await _prefsData.getData("lost");
    _level = await _prefsData.getData("level");
    _benefit = await _prefsData.getData("benef");
    _odds = await _prefsData.getData("odds");
    setState(() {});
  }

  void dataReset(){
    _prefsData.setBoolData("start3", false);
    _prefsData.setData("stake", "0");
    _prefsData.setData("startingstake", "0");
    _prefsData.setData("win", "0");
    _prefsData.setData("lost", "0");
    _prefsData.setData("level", "0");
    _prefsData.setData("benef", "0");
    _prefsData.setData("odds", "0");
    initialization();
  }
  void restart(BuildContext context, {String? message}) async {
    bool? success = await showDialog(
      context: context, 
      builder: (BuildContext context) => AmountForStarting(isForAmount: false, message: message ?? '',),
      barrierDismissible: false
    );
    if (success != null && success) {
      initialization();
      if(context.mounted) snackResult("", context);
    }
  }

  SizedBox myText(BuildContext context, String message) => SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.5),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const MyStyle(
            fontFamily: Controller.acmeFamily,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18),
      ),
    ),
  );
}
