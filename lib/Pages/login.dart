import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:projet0_strat/Components/code_checker.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/Data/controller.dart';
import 'package:projet0_strat/Components/presentation.dart';
import 'package:projet0_strat/Data/login_data.dart';
import 'package:projet0_strat/Data/route_named.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Controller.bgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            "DanDo",
            style: MyStyle(fontFamily: "acme", color: Controller.blackColor, fontWeight: FontWeight.w600, fontSize: 18),
          ),
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: (){
                context.goNamed(RoutesNamed.aboutapp);
              },
              icon: Icon(MdiIcons.informationVariantCircle),
              splashRadius: 20,
              iconSize: 25,
            )
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.transparent,
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Presentation(),
              const CodeChecker(),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.5,
                padding: EdgeInsets.zero,
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  onPressed: LoginData().launchUrl,
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
