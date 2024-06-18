import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projet0_strat/Components/click_to_buy_component.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/Controllers/controller.dart';
import 'package:projet0_strat/Controllers/login_controller.dart';

// ignore: must_be_immutable
class AboutApp extends StatelessWidget {
  AboutApp({super.key});
  Controller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: controller.bgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "A propos de DanDo",
            style: MyStyle(fontFamily: Get.put(Controller()).acmeFamily, color: Get.put(Controller()).blackColor, fontWeight: FontWeight.w600, fontSize: 17),
          ),
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: true,
        ),
        body: Container(
          width: Get.width,
          height: Get.height,
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
            child: ListView(physics: const ClampingScrollPhysics(), children: [
              RichText(
                  text: TextSpan(
                      style: MyStyle(
                          fontFamily: Get.put(Controller()).acmeFamily,
                          color: Get.put(Controller()).blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                      children: List.generate(
                          Get.put(LoginController()).titles.length,
                          (index) => TextSpan(
                                text: Get.put(LoginController()).titles[index],
                                style: TextStyle(
                                    color: index % 2 == 0
                                        ? Colors.red.shade700
                                        : Colors.black),
                              )))),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: Get.width,
                child: Text(
                  "Quelle est ta situation ?",
                  style: MyStyle(
                      fontFamily: Get.put(Controller()).acmeFamily,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
              ),
              Column(
                children: List.generate(
                  Get.put(LoginController()).problems.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: SizedBox(
                      width: Get.width,
                      child: Text(
                        Get.put(LoginController()).problems[index],
                        style: MyStyle(
                            fontFamily: Get.put(Controller()).acmeFamily,
                            color: Get.put(Controller()).blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: Get.width,
                child: Text(
                  "Si oui, alors cette application est faites pour toi.",
                  style: MyStyle(
                      fontFamily: Get.put(Controller()).acmeFamily,
                      color: Get.put(Controller()).blackColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(5),
                elevation: 10,
                child: InkWell(
                  onTap: Get.put(LoginController()).launchUrl,
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Get.put(Controller()).orangeColor,
                    ),
                    child: RichText(
                        text: TextSpan(
                            style: MyStyle(
                                fontFamily: Get.put(Controller()).acmeFamily,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15
                              ),
                            children: [
                          const TextSpan(
                              text: "Clique ici",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.teal,
                                  fontSize: 19)
                          ),
                          TextSpan(
                              text:
                                  ", obtiens ton code d'accès et change ta vie pour ${Get.put(LoginController()).price} seulement au lieu de 99 000f cfa.")
                        ])),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: Get.width,
                child: Text(
                  "Qu'est-ce que tu désires ?",
                  style: MyStyle(
                      fontFamily: Get.put(Controller()).acmeFamily,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
              ),
              Column(
                children: List.generate(
                  Get.put(LoginController()).desires.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: SizedBox(
                      width: Get.width,
                      child: Text(
                        Get.put(LoginController()).desires[index],
                        style: MyStyle(
                            fontFamily: Get.put(Controller()).acmeFamily,
                            color: Get.put(Controller()).blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: Get.width,
                child: Text(
                  "Évidemment que c'est possible ! Cette application, te permettra de :",
                  style: MyStyle(
                      fontFamily: Get.put(Controller()).acmeFamily,
                      color: Get.put(Controller()).blackColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
              ),
              Column(
                children: List.generate(
                    Get.put(LoginController()).capabilities.length,
                    (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: SizedBox(
                            width: Get.width,
                            child: Text(
                              Get.put(LoginController()).capabilities[index],
                              style: MyStyle(
                                  fontFamily: Get.put(Controller()).acmeFamily,
                                  color: Get.put(Controller()).blackColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        )),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: Get.width,
                child: RichText(
                    text: TextSpan(
                        style: MyStyle(
                            fontFamily: Get.put(Controller()).acmeFamily,
                            color: Get.put(Controller()).blackColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                        children: const [
                      TextSpan(
                        text:
                            "Cette application te donne toutes les clés pour devenir un parieur gagnant. ",
                      ),
                      TextSpan(
                        text: "N'est-ce pas merveilleux ?\n\n",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.teal),
                      ),
                      TextSpan(
                        text:
                            "Alors n'attends plus ! Réjoins nous maintaitenant et commence à gagner dès aujourd'hui !",
                      ),
                    ])),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Offre spécial !",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: Get.put(Controller()).acmeFamily,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              ),
              const ClickToBuy(),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(Get.put(LoginController()).contactIcons.length, (index) => Padding(
                padding: const EdgeInsets.all(5),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey.shade300,  
                  child: IconButton(
                    onPressed: (){
                      Get.put(LoginController()).launchUrl(index: index);
                    }, 
                    iconSize: 17,
                    icon: Get.put(LoginController()).contactIcons[index],
                  ),
                ),
              )),
              )
            ]
          ),
        ),
      ),
    );
  }
}
//Rejoignez notre communauté de parieurs gagnants.
//Ne ratez pas cette chance de booster vos gains.
//Devenez un expert en paris sportifs avec notre aide.
//Interface intuitive et facile à utiliser.
// Inscrivez-vous dès aujourd'hui et commencez à gagner !
//Veillez à ce que votre page d'accueil soit optimisée pour les conversions. (Lien Whatsapp)
// https://wa.me/15551234567
/*
[
  const Text(
    "Intégrez notre communauté de parieurs gagnants et boostez vos gains !",
    style: MyStyle(fontFamily: Get.put(Controller()).acmeFamily, color: Colors.black87, fontWeight: FontWeight.w900, fontSize: 20),
  ),
  SizedBox(height: Get.height / 50,),
  Text(
    "Avec notre aide et notre interface intuitive,\ndevenez un expert en paris en sportif et",
    style: MyStyle(fontFamily: Get.put(Controller()).acmeFamily, color: Colors.grey.shade800, fontWeight: FontWeight.w400, fontSize: 18),
  ),
  SizedBox(
  width: Get.width,
    child: Text(
      "commencer à gagner dès aujourd'hui !",
      textAlign: TextAlign.left,
      style: MyStyle(fontFamily: Get.put(Controller()).acmeFamily, color: Colors.grey.shade800, fontWeight: FontWeight.w600, fontSize: 18),
    ),
  ),
  SizedBox(
    height: Get.height / 25,
  ),
  Container(
    width: Get.width,
    height: Get.height / 4,
    margin: EdgeInsets.only(bottom: Get.height / 60),
    color: Colors.teal,
    child: const Text("Témoignages"),
  ),
  RichText(
    text: TextSpan(
      style: MyStyle(fontFamily: Get.put(Controller()).acmeFamily, color: Colors.grey.shade800, fontWeight: FontWeight.w400, fontSize: 17),
      children: const [
        TextSpan(
          text: "Obtenez votre code d'accès avec "
        ),
        TextSpan(
          text: "9 000 F CFA",
          style: MyStyle(fontFamily: Get.put(Controller()).acmeFamily, color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        TextSpan(
          text: " seulement au lieu de "
        ),
        TextSpan(
          text: "99 900 F CFA",
          style: MyStyle(fontFamily: Get.put(Controller()).acmeFamily, color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ]
    )
  ),
],
*/