import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/Controllers/controller.dart';
import 'package:projet0_strat/Controllers/login_controller.dart';
import 'package:projet0_strat/Components/presentation.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Get.put(Controller()).bgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "app-name",
            style: MyStyle(fontFamily: "acme", color: Get.put(Controller()).blackColor, fontWeight: FontWeight.w600, fontSize: 15),
          ),
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: Get.put(LoginController()).goToAboutApp, 
              icon: Icon(MdiIcons.informationVariantCircle),
              splashRadius: 20,
              iconSize: 25,
            )
          ],
        ),
        body: Container(
          width: Get.width,
          height: Get.height,
          color: Colors.transparent,
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(//Carroussel qui defile taduisant le text ci dessous
              //   width: Get.width / 3.4,
              //   height: Get.height / 8,
              //   color: Colors.amber,
              // ),
              // RichText(
              //   text: const TextSpan(
              //     style: MyStyle(fontFamily: "acme", color: Colors.black87, fontWeight: FontWeight.w400, fontSize: 17),
              //     children: [
              //       TextSpan(
              //         text: "-",
              //         style: TextStyle(
              //           fontSize: 25,
              //           fontWeight: FontWeight.bold,
              //           fontFamily: "roboto"
              //         )
              //       ),
              //       TextSpan(
              //         text: "Des fonctionnalités et des méthodes pour faire de vous un parieur rentable.\n"
              //       ),
              //       TextSpan(
              //         text: "-",
              //         style: TextStyle(
              //           fontSize: 25,
              //           fontWeight: FontWeight.bold,
              //           fontFamily: "roboto"
              //         )
              //       ),
              //       TextSpan(
              //         text: "Une équipe de dévéloppeurs à votre service."
              //       ),
              //     ]
              //   )
              // ),
              const Presentation(),
              Container(
                height: Get.height / 10,
                width: Get.width,
                alignment: Alignment.center,
                color: Colors.transparent,
                margin: EdgeInsets.only(top: Get.height / 9),
                child: Get.put(LoginController()).obx(
                  (state) => const SizedBox.shrink(),
                  onEmpty: RichText(
                    text: TextSpan(
                      style: MyStyle(fontFamily: "acme", color: Get.put(Controller()).blackColor, fontWeight: FontWeight.w500, fontSize: 15),
                      children: [
                        const TextSpan(
                          text: "Profitez-en vite !\n",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          )
                        ),
                        const TextSpan(
                          text: "Le code d'accès actuellement à ",
                        ),
                        TextSpan(
                          text: "${Get.put(LoginController()).price}  !\n",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold
                          )
                        ),
                        TextSpan(
                          text: "Nombre de place limitée !",
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontWeight: FontWeight.w700
                          )
                        )
                      ]
                    ),
                  ),
                  onLoading: SpinKitPouringHourGlassRefined(
                    color: Get.put(Controller()).tealColor,
                  ),
                  onError: (error) => Text(
                    error!, 
                    style: MyStyle(fontFamily: "acme", color: Colors.red.shade700, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              InkWell(
                onTap: Get.put(LoginController()).paste,
                child: Container(
                  width: Get.width, 
                  height: Get.height / 13,
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Get.put(Controller()).tealColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Get.put(Controller()).tealColor, width: 3)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: Get.width * 0.8,
                        padding: const EdgeInsets.all(10),
                        margin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: Get.put(Controller()).bgColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Obx(() => FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            Get.put(LoginController()).codeToPaste.value.contains("TZ") ? Get.put(LoginController()).codeToPaste.value.toUpperCase() : Get.put(LoginController()).codeToPaste.value,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                            style: MyStyle(
                              fontFamily: 'acme',
                              color: Get.put(Controller()).blackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 19.5
                            ),
                          ),
                        )),
                      ),
                      SizedBox(
                        width: Get.width * 0.15,
                        child: Icon(MdiIcons.contentPaste)
                      )
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: Get.put(LoginController()).codeChecker,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Get.put(Controller()).tealColor),
                  shape: MaterialStateProperty.all(const StadiumBorder()),
                ),
                child: const Text(
                  "Vérifier",
                  style: MyStyle(
                    fontFamily: 'acme',
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 15
                  ),
                ),
              ),
              Container(
                width: Get.width,
                height: Get.height / 3.5,
                padding: EdgeInsets.zero,
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  onPressed: Get.put(LoginController()).launchUrl, 
                  child: RichText(
                    text: const TextSpan(
                      style: MyStyle(fontFamily: "acme", color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
                      children: [
                        TextSpan(
                          text: "Vous n'avez pas de code ? ",
                        ),
                        TextSpan(
                          text: "Clique ici",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.teal,
                            fontSize: 17
                          )
                        )
                      ]
                    )
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
