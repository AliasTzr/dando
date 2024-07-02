import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:projet0_strat/Models/matches_model.dart';
import 'package:projet0_strat/Data/controller.dart';
import 'package:projet0_strat/Data/db_sql_project.dart';
import 'package:projet0_strat/Components/min_max_calculator.dart';
import 'package:projet0_strat/Data/methodes.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/Components/table_score_shower_component.dart';
import 'package:projet0_strat/Pages/pre_update_data.dart';

// ignore: must_be_immutable
class MatchDetails extends StatefulWidget {
  Duel match;
  MatchDetails({super.key, required this.match});

  @override
  State<MatchDetails> createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails> {
  DatabaseHelper databaseHelper  = DatabaseHelper();
  Future<void> _loadMatchData() async {
    Duel updatedMatch = await databaseHelper.getMatchById(widget.match.id!);
    setState(() {
      widget.match = updatedMatch;
    });
  }
  @override
  Widget build(BuildContext context) {
    List<String> scoresTeamAParseToList = widget.match.scoresTeamA.split(" ");
    List<String> scoresTeamBParseToList = widget.match.scoresTeamB.split(" ");
    String minTeamA = listFilled(scoresTeamAParseToList).reduce((value, element) => int.parse(value) < int.parse(element) ? value : element);
    String maxTeamA = listFilled(scoresTeamAParseToList).reduce((value, element) => int.parse(value) > int.parse(element) ? value : element);
    String minTeamB = listFilled(scoresTeamBParseToList).reduce((value, element) => int.parse(value) < int.parse(element) ? value : element);
    String maxTeamB = listFilled(scoresTeamBParseToList).reduce((value, element) => int.parse(value) > int.parse(element) ? value : element);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leadingWidth: 23,
          centerTitle: true,
          title: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              widget.match.championship,
              style: const MyStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  letterSpacing: 1,
                color: Controller.blackColor,
                fontFamily: "acme"
              ),
            ),
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: (){
                context.pop();
              },
              iconSize: 16,
              icon: const Icon(Icons.arrow_back_ios, color: Controller.tealColor,)
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(MdiIcons.fromString(widget.match.sport), color: Controller.blackColor,),
            ),
          ],
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 26,),
              ScoreShower(scoresTeamA: scoresTeamAParseToList, scoresTeamB: scoresTeamBParseToList, nameTeamA: widget.match.nameTeamA, nameTeamB: widget.match.nameTeamB,),
              SizedBox(height: MediaQuery.of(context).size.height / 20,),
              MinMaxCalculator(scoresA: scoresTeamAParseToList, scoresB: scoresTeamBParseToList, nameTeamA: widget.match.nameTeamA, nameTeamB: widget.match.nameTeamB,),
              SizedBox(height: MediaQuery.of(context).size.height / 23,),
              widget.match.sport == "basketball" ? Column(
                children: [
                Container(
                  padding: const EdgeInsets.only(left: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                        "Minimum par quartant  :    ${(int.parse(minTeamA) + int.parse(minTeamB))/4}",
                      textAlign: TextAlign.left,
                      style: const MyStyle(fontFamily: "acme", color: Colors.black, fontWeight: FontWeight.w500, fontSize: 17)
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Maximum par quartant  :    ${(int.parse(maxTeamA) + int.parse(maxTeamB))/4}",
                      textAlign: TextAlign.left,
                      style: const MyStyle(fontFamily: "acme", color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14)
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 23,),
                ],
              ): const SizedBox.shrink(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height * 0.06,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Controller.tealColor),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                  ),
                  onPressed: () async {
                    bool? updateSuccess = await showDialog(
                      context: context, 
                      builder: (_) => PreUpdateData(match: widget.match,),
                      barrierDismissible: false,
                    );
                    if(updateSuccess != null && updateSuccess && context.mounted){
                      await _loadMatchData();
                      if(context.mounted) snackResult("Mise à jour réussi", context, success: true);
                    }
                  },
                  child: const Text(
                    "Mettre à jour",
                    style: MyStyle(fontFamily: 'acme', color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
