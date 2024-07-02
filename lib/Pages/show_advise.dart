import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projet0_strat/Data/controller.dart';
import 'package:projet0_strat/Models/advises_model.dart';

class AdviseDetails extends StatelessWidget {
  final Advise advise;
  const AdviseDetails({super.key, required this.advise});
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
              style: const TextStyle(
                color: Controller.blackColor,
                fontSize: 17
              ),
            ),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: (){
                  context.pop();
                },
                iconSize: 16,
                icon: const Icon(Icons.arrow_back_ios, color: Controller.tealColor,)
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
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




