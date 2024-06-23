import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:projet0_strat/Data/methodes.dart';
import 'package:projet0_strat/Data/route_named.dart';
import 'package:projet0_strat/Models/prefs_data.dart';
import 'package:projet0_strat/api/api.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoginController extends GetxController with StateMixin<void> {
  late RxString codeToPaste;
  late RxInt textCaroussel;
  late PrefsData _prefsData;
  final String price = "12 990f cfa",
      _phoneNumber = "2250173871065";
  @override
  void onInit() {
    super.onInit();
    codeToPaste = "Cliquer ici pour coller le code".obs;
    textCaroussel = 0.obs;
    _prefsData = PrefsData();
    change(null, status: RxStatus.empty());
  }

  Future<void> _accesProvider(BuildContext context) async {
    change(null, status: RxStatus.loading());
    try {
      Api().useCode(codeToPaste.value).then((response) {
        _prefsData.setBoolData("isLogged", true);
        snackResult(response);
        context.goNamed(RoutesNamed.home);
        context.pop();  
      }, onError: (error) async {
        change(null, status: RxStatus.error(error.toString()));
        await Future.delayed(const Duration(seconds: 10));
        change(null, status: RxStatus.empty());
      });
    } catch (e) {
      change(null,
          status: RxStatus.error("Oups !! Veuillez réessayer plus tard"));
      snackResult(
        "Vérifier votre connexion internet.",
        success: false,
      );
      await Future.delayed(const Duration(seconds: 10));
      change(null, status: RxStatus.empty());
    }
  }

  Future<void> paste() async {
    String code = await FlutterClipboard.paste();
    if (code.isNotEmpty && code.trim().isNotEmpty) {
      codeToPaste(code.replaceAll(" ", ""));
    } else {
      codeToPaste("Cliquer ici pour coller le code");
      snackResult("Aucun code recu");
    }
  }

  void codeChecker(BuildContext context) {
    if (codeToPaste.value.length == 24 && codeToPaste.value.contains("TZ")) {
      _accesProvider(context);
    } else {
      snackResult("Code incorrecte", success: false);
    }
  }

  Future<void> launchUrl({int? index}) async {
    String url = 'https://wa.me/$_phoneNumber';
    if (index == 1) {
      url = 'https://t.me/+$_phoneNumber';
    }
    // if (index == 2) {
    //   url = "https://www.youtube.com/@BighID_RTaZed";
    // }
    // if (index == 5) {
    //   url = "https://www.tiktok.com/@byggy31";
    // }
    try {
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        snackResult("Url incorrect", success: false);
      }
    } catch (e) {
      snackResult("Vérifier votre connexion internet", success: false);
    }
  }
}
