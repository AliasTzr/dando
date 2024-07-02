import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/Data/controller.dart';
import 'package:projet0_strat/Data/db_sql_project.dart';
import 'package:projet0_strat/Data/methodes.dart';
import 'package:projet0_strat/Data/route_named.dart';
import 'package:projet0_strat/Models/matches_model.dart';
import 'package:projet0_strat/Pages/data_saved.dart';
import 'package:projet0_strat/Pages/home.dart';
import 'package:projet0_strat/features/noti_service.dart';

class ScreenManager extends StatefulWidget {
  const ScreenManager({super.key});

  @override
  State<ScreenManager> createState() => _ScreenManagerState();
}

class _ScreenManagerState extends State<ScreenManager> {
  int _currentPage = 1;
  late  final PageController _pageController;
  DatabaseHelper databaseHelper = DatabaseHelper();
  final GlobalKey<_ScreenManagerState> myKey = GlobalKey();
  final Map<int, Widget> _pagesWidget = <int, Widget>{
    0: const Text(
      "Sauvegardes",
      style: MyStyle(fontFamily: 'roboto', color: Colors.black, fontWeight: FontWeight.normal, fontSize: 14),
    ),
    1: const Text(
      "Acceuil",
      style: MyStyle(fontFamily: 'roboto', color: Colors.black, fontWeight: FontWeight.normal, fontSize: 14),
    ),
  };
  @override
  void initState() {
    _pageController = PageController(initialPage: 1);
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
          title: const Text(
            "Stratégie Basket",
            style: MyStyle(fontFamily: Controller.oswaldFamily, color: Controller.tealColor, fontWeight: FontWeight.w600, fontSize: 16),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(MediaQuery.of(context).size.height / 35),
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.1,
                child: CupertinoSlidingSegmentedControl(
                  groupValue: _currentPage,
                  children: _pagesWidget,
                  onValueChanged: (newValue) {
                    setState(() {
                      _currentPage = newValue!;
                    });
                    _changeScreen(_currentPage);
                  }
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
            children: const [Storage(), Home()],
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
        setState(() {
          _currentPage = 0;
        });
        _changeScreen(_currentPage);
        Duel duel = await databaseHelper.getMatchById(int.parse(event));
        if (mounted) context.goNamed(RoutesNamed.matchDetails, extra: duel);
      } else {
        if (mounted) snackResult("Quelque chose à mal fonctionné !", context, success: false);
      }
    });
  }
}