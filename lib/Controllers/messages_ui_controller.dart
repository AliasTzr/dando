// import 'package:get/get.dart';
// import 'package:projet0_strat/Controllers/controller.dart';
// import 'package:projet0_strat/Data/methodes.dart';
// import 'package:projet0_strat/Models/me.dart';

// class MessagesUIController extends GetxController {
//   late RxList<Message> messagesList, filterList;
//   late RxString message;
//   final Me _me = Me();
//   final Controller c = Get.find();
//   String previousDate = "";
//   @override
//   void onInit() {
//     super.onInit();
//     message = "".obs;
//     messagesList = <Message>[].obs;
//     filterList = <Message>[].obs;
//     fetchMessages();
//     filtredList("all");
//   }

//   Future<void> fetchMessages() async {
//     message("Chargement ...");
//     try {
//       messagesList.value = await _me.client.messages.fetchMessages();
//       if (messagesList.isNotEmpty) {
//         message("");
//       } else {
//         message("La liste est vide");
//       }
//     } catch (e) {
//       message("Impossible de réccupérer les données");
//       snackResult("Vérifier votre connexion internet.", success: false);
//     }
//   }
//   void filtredList(String key){
//     filterList(key == "all" ? messagesList : messagesList.where((value) => value.type == key).toList(growable: false).obs);
//   }
// }
