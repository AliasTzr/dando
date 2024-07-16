import 'package:flutter/material.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/Data/controller.dart';

class TripleToXTips extends StatelessWidget {
  TripleToXTips({super.key});
  final List<String> textsAvises = <String>[
    "Combinez deux matchs de cotes de 1,75 minimum pour avoir une cote de 3.",
    "Faites les analyses avec uniquement la stratégie basket-ball.",
    "Jouez un seul coupon par jour (les 2 meilleures analyses de la journée).",
    "Jouez seulement sur les grandes compétitions.",
    "Préférence de sport : basket-ball et hockey sur glace.",
    "Avoir le budget nécessaire pour aller jusqu'au dernier niveau",
    "Recommencer au niveau 1 après chaque victoire.",
    "Ne faites rien d'autre que ce qui est mentionné ici.",
  ], textWarning = <String>[
    "Perdre successivement 10 fois d'affilée (ce qui est vraiment improbable).",
    "Danger : Vous perdrez 81 000 F si vous perdez 10 fois successivement."
  ];

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const MyStyle(fontFamily:  Controller.poppinsFamily, color: Colors.black, fontWeight: FontWeight.w600, fontSize: 13),
        children: [
          tilte("Conseils"),
          TextSpan(
                children: List.generate(textsAvises.length,
            (int index) => TextSpan(
              children: [
                star(),
                text(textsAvises[index]
                )
              ]
            )
            )
          ),
          tilte("Perte possible:", color: Controller.redColor),
          TextSpan(
            children: List.generate(textWarning.length, 
              (int index) => TextSpan(
                children: [
                  star(red: false),
                  text(textWarning[index])
                ]
              )
            )
          )
        ]
      )
    );
  }

  TextSpan star({bool? red}) => TextSpan(
    text: "*",
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: red ?? true ? Colors.blue.shade600 : Controller.redColor
    )
  );

  TextSpan text(String text) => TextSpan(
    text: "$text\n"
  );

  TextSpan tilte(String text, {Color? color}) => TextSpan(
    text: "$text\n",
    style: MyStyle(fontFamily: Controller.oswaldFamily, color: color ?? Colors.blue.shade600, fontWeight: FontWeight.bold, fontSize: 17)
  );
}