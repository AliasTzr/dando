// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:projet0_strat/Components/app_bar_component.dart';
// import 'package:projet0_strat/Components/my_line_widget.dart';
// import 'package:projet0_strat/Components/my_text_style.dart';
// import 'package:projet0_strat/Controllers/controller.dart';


// class TextReader extends StatelessWidget {
//   // final Message message;
//   TextReader({super.key, required this.message});
//   final Controller controller = Get.find();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyAppBar(title: message.title, canPop: true, canSendData: false),
//       backgroundColor: controller.bgColor,
//       body: Container(
//         width: Get.width,
//         height: Get.height,
//         padding: const EdgeInsets.all(10),
//         child: ListView(
//           physics: const BouncingScrollPhysics(),
//           children: [
//             MyLine(name: "Titre: ", value: message.title),
//             MyLine(name: "Publié le: ", value: message.date),
//             MyLine(name: "à: ", value: message.hour),
//             const SizedBox(height: 30,),
//             SizedBox(
//               width: Get.width,
//               child: Text(
//                 message.contentLink,
//                 textAlign: TextAlign.justify,
//                 textDirection: TextDirection.ltr,
//                 softWrap: true,
//                 style: const MyStyle(
//                   fontFamily: "quicksand",
//                   color: Colors.black,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 18
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
