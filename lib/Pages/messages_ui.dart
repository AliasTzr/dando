import 'package:flutter/material.dart';


class MessagesUI extends StatelessWidget{
  const MessagesUI({super.key});
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
    // Scaffold(
      // backgroundColor: Get.put(MessagesUIController()).c.bgColor,
      // body: SizedBox(
      //   width: Get.width,
      //   height: Get.height,
      //   child: LiquidPullToRefresh(
      //     color: Get.put(MessagesUIController()).c.tealColor,
      //     height: 150,
      //     backgroundColor: const Color(0xFFDDDBE6),
      //     animSpeedFactor: 1.5,
      //     showChildOpacityTransition: true,
      //     onRefresh: () async {
      //       try {
      //         Get.put(MessagesUIController()).messagesList.clear();
      //         Get.put(MessagesUIController()).message("");
      //         Get.put(MessagesUIController()).filterList.clear();
      //         await Get.put(MessagesUIController()).fetchMessages();
      //         Get.put(MessagesUIController()).filtredList("all");
      //       } catch (e) {
      //         snackResult("Vérifier votre connexion internet.", success: false);
      //       }
      //     },
      //     child: ListView(
      //       children: [
      //         Obx(() {
      //           if (Get.put(MessagesUIController()).message.isEmpty) {
      //             return SizedBox(
      //               width: Get.width,
      //               height: Get.height,
      //               child: ListView.builder(
      //                   itemCount:
      //                       Get.put(MessagesUIController()).filterList.length,
      //                   itemBuilder: (context, index) {
      //                     if (Get.put(MessagesUIController())
      //                         .filterList
      //                         .isNotEmpty) {
      //                       if (Get.put(MessagesUIController()).previousDate !=
      //                           Get.put(MessagesUIController())
      //                               .filterList[index]
      //                               .date) {
      //                         Get.put(MessagesUIController()).previousDate =
      //                             Get.put(MessagesUIController())
      //                                 .filterList[index]
      //                                 .date;
      //                         return MessagesListTile(
      //                           message: Get.put(MessagesUIController())
      //                               .filterList[index],
      //                           showDivider: true,
      //                           showDate: true,
      //                         );
      //                       } else {
      //                         return MessagesListTile(
      //                           message: Get.put(MessagesUIController())
      //                               .filterList[index],
      //                           showDivider: false,
      //                           showDate: false,
      //                         );
      //                       }
      //                     } else {
      //                       return TextContainer(
      //                         data: "Aucun message",
      //                         isGreyBG: false,
      //                         isForGambler: true,
      //                       );
      //                     }
      //                   }),
      //             );
      //           } else {
      //             return TextContainer(
      //               data: Get.put(MessagesUIController()).message.value,
      //               isGreyBG: false,
      //               isForGambler: true,
      //             );
      //           }
      //         }),
      //       ],
      //     ),
      //   ),
      // ),
      // floatingActionButton: SpeedDial(
      //   activeIcon: MdiIcons.close,
      //   buttonSize: const Size(60, 60),
      //   curve: Curves.bounceOut,
      //   backgroundColor: Colors.teal,
      //   children: [
      //     MySpeedDialChild(
      //         iconData: MdiIcons.viewList,
      //         function: () {
      //           Get.put(MessagesUIController()).filtredList("all");
      //         },
      //         color: 0xFF634545),
      //     MySpeedDialChild(
      //         iconData: MdiIcons.microphone,
      //         function: () {
      //           Get.put(MessagesUIController()).filtredList("microphone");
      //         },
      //         color: 0xFF768532),
      //     MySpeedDialChild(
      //         iconData: MdiIcons.video,
      //         function: () {
      //           Get.put(MessagesUIController()).filtredList("video");
      //         },
      //         color: 0xFFD16014),
      //     MySpeedDialChild(
      //         iconData: MdiIcons.formatText,
      //         function: () {
      //           Get.put(MessagesUIController()).filtredList("formatText");
      //         },
      //         color: 0xFF4C60A9),
      //     MySpeedDialChild(
      //         iconData: MdiIcons.image,
      //         function: () {
      //           Get.put(MessagesUIController()).filtredList("image");
      //         },
      //         color: 0xFF1A6161),
      //   ],
      //   child: Icon(MdiIcons.filter),
      // ),
    // );
  }
}
