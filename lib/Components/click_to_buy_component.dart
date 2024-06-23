import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/Controllers/controller.dart';
import 'package:projet0_strat/Controllers/login_controller.dart';

class ClickToBuy extends StatelessWidget {
  const ClickToBuy({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "${Get.put(LoginController()).price} au lieu de 99 000f fcfa pour accéder à toutes les fonctionnalités de l'application.",
            textAlign: TextAlign.center,
            style: const MyStyle(fontFamily: Controller.acmeFamily, color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15),
          ),
        ),
        SizedBox(
          width: Get.width - 15,
          child: MaterialButton(
            onPressed: Get.put(LoginController()).launchUrl, 
            color: Controller.tealColor,
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: const Text(
              "Clique ici pour acheter ton code",
              style: MyStyle(fontFamily: "acme", color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
            )
          ),
        ),
      ],
    );
  }
}