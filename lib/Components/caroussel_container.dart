import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/Controllers/controller.dart';
import 'package:projet0_strat/Controllers/login_controller.dart';

// ignore: must_be_immutable
class CarrousselContainer extends Container {
  String? title, link;
  String content;
  CarrousselContainer({super.key, this.title,  required this.content, this.link}) : super(
    height: Get.height / 8,
    width: Get.width / 1.45,
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        title != null ? Text(
          title,
          style: const MyStyle(fontFamily: "acme", color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ) : const SizedBox.shrink(),
        Text(
          content,
          style: const MyStyle(fontFamily: "acme", color: Colors.black, fontWeight: FontWeight.normal, fontSize: 14),
        ),
        link != null ? const SizedBox(height: 5,) : const SizedBox.shrink(),
        link != null ? InkWell(
          onTap: Get.put(LoginController()).launchUrl,
          child: Row(
            children: [
              Text(
                link, 
                style: MyStyle(fontFamily: "acme", color: Get.put(Controller()).tealColor, fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Icon(MdiIcons.arrowRight, size: 14, color: Get.put(Controller()).tealColor,)
            ],
          ),
        ) : const SizedBox.shrink()
      ],
    ),
  );

  }