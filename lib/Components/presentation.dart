import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:projet0_strat/Components/caroussel_container.dart';
import 'package:projet0_strat/Data/login_data.dart';

class Presentation extends StatelessWidget {
  const Presentation({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [0, 1, 2, 3, 4, 5].map((i) => Builder(
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 8,
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
                  width: MediaQuery.of(context).size.width / 3.8,
                  height: MediaQuery.of(context).size.height / 8,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle
                  ),
                  child: Image.asset(
                    LoginData.images[i],
                    fit: BoxFit.fill,
                  ),
                ),
                CarrousselContainer(
                  title: i == 0 || i == 2 ? LoginData.textCarousselList[i].split(", ")[0] : null,
                  content: i == 0 || i == 2 ? LoginData.textCarousselList[i].split(", ")[1] : i == 5 ? LoginData.textCarousselList[i].split("!")[0] : LoginData.textCarousselList[i],
                  link: i == 5 ? LoginData.textCarousselList[i].split("!")[1] : null,
                )
              ],
            ),
          );
        }
      )).toList(),
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height / 8,
        viewportFraction: 1,
        autoPlay: true,
        scrollPhysics: const ClampingScrollPhysics(),
        autoPlayInterval: const Duration(seconds: 10)
      )
    );
  }
}