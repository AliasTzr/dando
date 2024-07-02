import 'package:flutter/material.dart';
import 'package:projet0_strat/Components/my_text_style.dart';


class MyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final bool isPassword;
  const MyTextField({super.key, required this.hintText, required this.textEditingController, required this.isPassword});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: textEditingController,
          cursorColor: Colors.black,
          keyboardType: isPassword ? TextInputType.visiblePassword : TextInputType.emailAddress,
          obscureText: isPassword,
          style: const MyStyle(fontFamily: 'quicksand', color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15),
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(5),
          ),
        )
    );
  }
}
