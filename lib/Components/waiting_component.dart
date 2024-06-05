import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:projet0_strat/Components/my_text_style.dart';

class WaitingComponent extends StatelessWidget {
  final bool isInitApp;
  const WaitingComponent({super.key, required this.isInitApp});
  @override
  Widget build(BuildContext context) {
    return Container(
      color:isInitApp ?Colors.white : Colors.transparent,
      width: Get.width,
      height: Get.height,
      alignment: Alignment.center,
      child: Container(
        width: Get.width * 0.90,
        height: Get.height / 4,
        color: Colors.white,
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitFadingCircle(
              color: Colors.black,
              size: 50.0,
            ),
            SizedBox(height: 20.0),
            Text(
              "Chargement en cours...",
              style: MyStyle(fontFamily: 'quicksand', color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}