import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projet0_strat/Models/advises_model.dart';
import 'package:projet0_strat/Controllers/controller.dart';
//AdviseDetails

class AdviseDetails extends StatelessWidget {
  AdviseDetails({super.key});
  final Controller controller = Get.put(Controller());
  final Advise advise = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leadingWidth: 23,
            centerTitle: true,
            title: Text(
                advise.title,
              style: TextStyle(
                color: controller.blackColor,
                fontSize: 17
              ),
            ),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: (){
                  Get.back();
                },
                iconSize: 16,
                icon: Icon(Icons.arrow_back_ios, color: controller.tealColor,)
            ),
          ),
          body: Container(
            height: controller.height,
            width: controller.width,
            color: Colors.white,
            alignment: Alignment.center,
            child: Image.asset(
              advise.description,
              fit: BoxFit.contain,
            ),
          ),
        )
    );
  }
}




