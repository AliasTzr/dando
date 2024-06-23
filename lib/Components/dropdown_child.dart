import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/Controllers/controller.dart';

class DropdownChild extends Container {
  final String text, icon;
  DropdownChild({super.key, required this.text, required this.icon}) : super(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const MyStyle(fontFamily: Controller.poppinsFamily, color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14),
        ),
        icon != "Type de sport" ? Icon(MdiIcons.fromString(icon)) : const SizedBox.shrink()
      ],
    )
  );

}