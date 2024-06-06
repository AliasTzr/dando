import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/Controllers/controller.dart';
import 'package:projet0_strat/Data/db_sql_project.dart';
import 'package:projet0_strat/Data/methodes.dart';
import 'package:projet0_strat/Models/matches_model.dart';
import 'package:projet0_strat/Pages/show_match_2.dart';
import 'package:projet0_strat/features/noti_service.dart';

class ScreenManagerController extends GetxController {
  RxInt currentPage = 1.obs;
  final Controller controller = Get.put(Controller());
  late  final PageController pageController;
  DatabaseHelper databaseHelper = DatabaseHelper();
  final Map<int, Widget> pagesWidget = <int, Widget>{
    0: const Text(
      "Sauvegardes",
      style: MyStyle(fontFamily: 'roboto', color: Colors.black, fontWeight: FontWeight.normal, fontSize: 14),
    ),
    1: const Text(
      "Acceuil",
      style: MyStyle(fontFamily: 'roboto', color: Colors.black, fontWeight: FontWeight.normal, fontSize: 14),
    ),
  };

  listenToNotification() {
    NotificationService.onClickNotification.stream.listen((event) async {
      if (int.parse(event) != 0 && event.isNumericOnly) {
        Duel duel = await databaseHelper.getMatchById(int.parse(event));
        Get.to(
          () => MatchDetails2(match: duel),
          curve: Curves.decelerate,
          duration: const Duration(microseconds: 500),
          transition: Transition.leftToRightWithFade,
        );
      } else {
        snackResult("Quelque chose à mal fonctionné !", success: false);
      }
    });
  }
  
  @override
  void onInit() {
    pageController = PageController(initialPage: 1);
    listenToNotification();
    super.onInit();
  }

  @override
  void onClose() {
    databaseHelper.closeDatabase();
    super.onClose();
  }

  void changeScreen() async {
    await pageController.animateToPage(
      currentPage.value,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut
    );
  }
}