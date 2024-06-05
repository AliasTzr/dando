import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:projet0_strat/Models/matches_model.dart';
import 'package:projet0_strat/Controllers/controller.dart';
import 'package:projet0_strat/Data/db_sql_project.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/Pages/show_match.dart';

class Storage extends StatefulWidget {
  const Storage({super.key});

  @override
  State<Storage> createState() => _StorageState();
}

class _StorageState extends State<Storage> {
  final Controller controller = Get.put(Controller());
  final GlobalKey<AnimatedListState> _keyList = GlobalKey();
  List<Duel> _matchesData = [];
  Future refreshMatchesState() async {
    _matchesData = await databaseHelper.getMatches();
  }
  DatabaseHelper databaseHelper = DatabaseHelper();
  void goToMatchDetails(Duel duel) {
    Get.to(
      () => MatchDetails(match: duel),
      curve: Curves.decelerate,
      duration: const Duration(microseconds: 500),
      transition: Transition.leftToRightWithFade,
    )?.then((_) => setState(() {}));
  }

  @override
  void dispose() {
    databaseHelper.closeDatabase();
    super.dispose();
  }

  Future<void> _removeItem(int index) async {
    _keyList.currentState!.removeItem(
        index,
        (context, animation) => SizeTransition(
          sizeFactor: animation,
          child: const Card(
            elevation: 0,
            color: Colors.red,
            child: Center(
              child: Text(
                "Supprimer",
                style: MyStyle(fontFamily: 'acme', color: Colors.white, fontWeight: FontWeight.normal, fontSize: 16),
              ),
            ),
          ),
        ),
        duration: const Duration(milliseconds: 500)
    );
    await databaseHelper.deleteMatch(_matchesData[index].id);
    _matchesData.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: databaseHelper.getMatches(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: Text(
                "Chargement...",
              style: GoogleFonts.acme(
                color: Colors.grey
              ),
            )
          );
        }else if(snapshot.hasData){
          _matchesData = snapshot.data!;
          return _matchesData.isNotEmpty ? AnimatedList(
              initialItemCount: _matchesData.length,
              key: _keyList,
              itemBuilder: (context, int index, animation){
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: controller.width /20),
                  child: SizeTransition(
                    sizeFactor: animation,
                    key: UniqueKey(),
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      elevation: 3,
                      child: ListTile(
                        contentPadding: const EdgeInsets.only(left: 10, top: 10),
                        horizontalTitleGap: 0,
                        minVerticalPadding: 0,
                        leading: Icon(_matchesData[index].sport == "Type de sport" ? MdiIcons.fileQuestionOutline : MdiIcons.fromString(_matchesData[index].sport), color: controller.tealColor,),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: controller.width / 1.85,
                              alignment: Alignment.centerLeft,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "${_matchesData[index].nameTeamA} vs ${_matchesData[index].nameTeamB}",
                                  style: const MyStyle(fontFamily: 'acme', color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              width: controller.width / 4.9,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "${_matchesData[index].championship}  ",
                                  style: const MyStyle(fontFamily: 'acme', color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${_matchesData[index].dataMatch}   à   ${_matchesData[index].timeMatch}",
                              style: MyStyle(fontFamily: 'acme', color: Colors.grey.shade600, fontWeight: FontWeight.w600, fontSize: 13),
                            ),
                            IconButton(
                                onPressed: () {
                                  _removeItem(index);
                                },
                                splashRadius: 25,
                                iconSize: 18,
                                icon: const Icon(Icons.delete, color: Colors.redAccent,)
                            ),
                          ],
                        ),
                        onTap: () {
                          goToMatchDetails(_matchesData[index]);
                        },
                      ),
                    ),
                  ),
                );
              }
          ) : Center(
            child: Text(
                "Aucune sauvegarde",
              style: GoogleFonts.acme(
                color: Colors.grey,
                wordSpacing : 3
              ),
            ),
          );
        } else if(snapshot.hasError){
          return Center(child: Text("Erreur dans la récuperation des données", style: GoogleFonts.acme(),),);
        }
        return Center(child: Text("Quelque chose n'a pas fonctionné", style: GoogleFonts.acme()),);
      }
    );
  }
}