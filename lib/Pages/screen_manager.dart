import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/Data/controller.dart';
import 'package:projet0_strat/Data/db_sql_project.dart';
import 'package:projet0_strat/Data/methodes.dart';
import 'package:projet0_strat/Data/route_named.dart';
import 'package:projet0_strat/Models/matches_model.dart';
import 'package:projet0_strat/Pages/home.dart';
import 'package:projet0_strat/Pages/triple_to_x.dart';
import 'package:projet0_strat/features/noti_service.dart';

class ScreenManager extends StatefulWidget {
  const ScreenManager({super.key});

  @override
  State<ScreenManager> createState() => _ScreenManagerState();
}

class _ScreenManagerState extends State<ScreenManager> {
  int _currentPage = 0;
  late  final PageController _pageController;
  DatabaseHelper databaseHelper = DatabaseHelper();
  final GlobalKey<_ScreenManagerState> myKey = GlobalKey();
  final List<String> _titles = <String>[
    "Basketball",
    "des montantes",
  ];
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    listenToNotification();
    super.initState();
  }
  @override
  void dispose() {
    databaseHelper.closeDatabase();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Stratégie ${_titles[_currentPage]}",
            style: const  MyStyle(fontFamily: Controller.oswaldFamily, color: Controller.tealColor, fontWeight: FontWeight.w600, fontSize: 20),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: (){
                context.goNamed(RoutesNamed.storage);
              },
              iconSize: 30,
              color: Colors.black,
              icon: Icon(MdiIcons.database)
            )
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(MediaQuery.of(context).size.height / 20),
            child: Padding(
              padding: const EdgeInsets.only(top: 5,),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_titles.length,
                  (int i)=> InkWell(
                    onTap: () {
                      setState(() {
                        _currentPage = i;
                      });
                      _changeScreen(_currentPage);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                        width: MediaQuery.of(context).size.width / 5,
                        height: MediaQuery.of(context).size.height / 19,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black12,
                          border: i == _currentPage ? Border.all(
                            width: 3,
                            color: Colors.teal
                          ) : null
                        ),
                        child: Icon(MdiIcons.fromString(i ==0 ? "basketballHoopOutline" : "finance"), size: 30,),
                      ),
                  ),
                  )
                ),
              ),
            ),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: const [Home(), TripleToX()],
          ),
        ),
      ),
    );
  }
  void _changeScreen(int value) async {
    await _pageController.animateToPage(
      value,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut
    );
    // ).then((val){setState(() {});});
  }
  listenToNotification() {
    NotificationService.onClickNotification.stream.listen((event) async {
      if (int.parse(event) != 0 && isNumeric(event)) {
        Duel duel = await databaseHelper.getMatchById(int.parse(event));
        if (mounted) context.goNamed(RoutesNamed.matchDetails, extra: duel);
      } else {
        if (mounted) snackResult("Quelque chose à mal fonctionné !", context, success: false);
      }
    });
  }
}