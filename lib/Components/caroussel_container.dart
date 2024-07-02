import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/Data/controller.dart';
import 'package:projet0_strat/Data/login_data.dart';


  class CarrousselContainer extends StatelessWidget {
  final String? title, link;
  final String content;
  const CarrousselContainer({super.key, this.title,  required this.content, this.link});

  @override
  Widget build(BuildContext context) {
    return Container(
    height: MediaQuery.of(context).size.height / 8,
    width: MediaQuery.of(context).size.width / 1.45,
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        title != null ? Text(
          title!,
          style: const MyStyle(fontFamily: "acme", color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ) : const SizedBox.shrink(),
        Text(
          content,
          style: const MyStyle(fontFamily: "acme", color: Colors.black, fontWeight: FontWeight.normal, fontSize: 14),
        ),
        link != null ? const SizedBox(height: 5,) : const SizedBox.shrink(),
        link != null ? InkWell(
          onTap: LoginData().launchUrl,
          child: Row(
            children: [
              Text(
                link!, 
                style: const MyStyle(fontFamily: "acme", color: Controller.tealColor, fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Icon(MdiIcons.arrowRight, size: 14, color: Controller.tealColor,)
            ],
          ),
        ) : const SizedBox.shrink()
      ],
    ),
  );
  }
}