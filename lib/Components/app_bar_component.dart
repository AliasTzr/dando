import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:projet0_strat/Components/my_icon_button.dart';
import 'package:projet0_strat/Controllers/controller.dart';
import 'my_text_style.dart';

// ignore: must_be_immutable
class MyAppBar extends AppBar implements PreferredSizeWidget{
  final Controller controller = Get.put(Controller());
  Function? function;
  MyAppBar({super.key, required String title, required bool canPop, required bool canSendData, this.function}) : super(
    title: Text(
      title,
      style: const MyStyle(
          fontFamily: 'lobster',
          color: Colors.black,
          fontWeight: FontWeight.w300,
          fontSize: 17,
      ),
    ),
    leading: canPop ? MyIconButton(iconData: MdiIcons.arrowLeftDropCircleOutline, isLeading: true) : const SizedBox.shrink(),
    actions: canSendData ? [
      MyIconButton(iconData: MdiIcons.exportVariant, isLeading: false, function: (){function?.call();},)
    ] : [],
    backgroundColor: const Color(0xFFF5F6F4),
    elevation: 0, centerTitle: true,
    automaticallyImplyLeading: false,
  );
}

