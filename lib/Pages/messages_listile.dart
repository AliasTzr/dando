// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:projet0_client/projet0_client.dart';
// import 'package:projet0_strat/Controllers/controller.dart';
// import 'package:projet0_strat/Pages/audio_reader.dart';
// import 'package:projet0_strat/Pages/image_reader.dart';
// import 'package:projet0_strat/Pages/text_reader.dart';
// import 'package:projet0_strat/Pages/video_reader.dart';

// class MessagesListTile extends StatelessWidget {
//   final Message message;
//   final bool showDivider, showDate;
//   MessagesListTile({super.key,required this.message, required this.showDivider, required this.showDate});
//   final Controller controller = Get.find();
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         showDivider ? const Divider(
//           color: Colors.grey,
//         ) : const SizedBox.shrink(),
//         showDate ? Text(
//           "publié le : ${message.date}",
//           style: const TextStyle(
//               fontFamily: 'quicksand',
//               color: Colors.grey,
//               fontSize: 15
//           ),
//         ) : const SizedBox.shrink(),
//         ListTile(
//           leading: CircleAvatar(
//             backgroundColor: Colors.black12,
//             radius: 25,
//             child: Icon(MdiIcons.fromString(message.type)),
//           ),
//           title: Container(
//             margin: const EdgeInsets.only(bottom: 15),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   message.title,
//                   style: const TextStyle(
//                     fontFamily: 'Oswald',
//                     fontSize: 18,
//                     letterSpacing: 1,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           subtitle: Text(
//             message.hour,
//             style: const TextStyle(
//                 fontFamily: 'quicksand',
//                 color: Colors.grey,
//                 fontSize: 13
//             ),
//           ),
//           contentPadding: const EdgeInsets.symmetric(vertical: 5),
//           onTap: (){
//             Get.to(
//               () => message.type == "formatText" ? TextReader(message: message,) 
//               : message.type == "microphone" ? const AudioReader()
//               : message.type == "video" ? const VideoReader() : const ImageReader(),
//               transition: Transition.leftToRightWithFade
//             );
//           },
//         ),
//       ],
//     );
//   }
// }