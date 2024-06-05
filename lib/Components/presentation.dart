import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projet0_strat/Components/caroussel_container.dart';
import 'package:projet0_strat/Controllers/login_controller.dart';

class Presentation extends StatelessWidget {
  const Presentation({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [0, 1, 2, 3, 4, 5].map((i) => Builder(
        builder: (BuildContext context) {
          return Container(
            width: Get.width,
            height: Get.height / 8,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Get.width / 3.8,
                  height: Get.height / 8,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle
                  ),
                  child: Image.asset(
                    Get.put(LoginController()).images[i],
                    fit: BoxFit.fill,
                  ),
                ),
                CarrousselContainer(
                  title: i == 0 || i == 2 ? Get.put(LoginController()).textCarousselList[i].split(", ")[0] : null,
                  content: i == 0 || i == 2 ? Get.put(LoginController()).textCarousselList[i].split(", ")[1] : i == 5 ? Get.put(LoginController()).textCarousselList[i].split("!")[0] : Get.put(LoginController()).textCarousselList[i],
                  link: i == 5 ? Get.put(LoginController()).textCarousselList[i].split("!")[1] : null,
                )
              ],
            ),
          );
        }
      )).toList(), 
      options: CarouselOptions(
        height: Get.height / 8,
        viewportFraction: 1,
        autoPlay: true,
        scrollPhysics: const ClampingScrollPhysics(),
        autoPlayInterval: const Duration(seconds: 10)
      )
    );
  }
}