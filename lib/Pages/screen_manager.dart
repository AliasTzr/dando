import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/Controllers/controller.dart';
import 'package:projet0_strat/Controllers/screen_manager_controller.dart';
import 'package:projet0_strat/Pages/data_saved.dart';
import 'package:projet0_strat/Pages/home.dart';

class ScreenManager extends GetWidget<ScreenManagerController> {
  const ScreenManager({super.key});

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
            preferredSize: Size.fromHeight(Get.height / 35),
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: SizedBox(
                width: Get.width / 1.1,
                child: Obx(() => CupertinoSlidingSegmentedControl(
                  groupValue: Get.put(ScreenManagerController()).currentPage.value,
                  children: Get.put(ScreenManagerController()).pagesWidget,
                  onValueChanged: (newValue) {
                    Get.put(ScreenManagerController()).currentPage(newValue!);
                    Get.put(ScreenManagerController()).changeScreen();
                  }
                )),
              ),
            ),
          ),
        ),
        body: Container(
          width: Get.width,
          height: Get.height,
          color: Colors.white,
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: Get.put(ScreenManagerController()).pageController,
            children: const [Storage(), Home()],
          ),
        ),
      ),
    );
  }
}