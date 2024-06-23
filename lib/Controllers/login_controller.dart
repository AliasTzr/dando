import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:projet0_strat/Data/methodes.dart';
import 'package:projet0_strat/Data/route_named.dart';
import 'package:projet0_strat/Models/prefs_data.dart';
import 'package:projet0_strat/api/api.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoginController extends GetxController with StateMixin<void> {
  List<String> menuItem = ["Bienvenue", "J'ai un code"],
      titles = [
        "Grosse occasion ",
        "pour profiter des gains sans fin !\n\nGagner jusqu'à ",
        "1.000.000f cfa",
        " en quelques jours seulement, c'est facile avec ",
        "cette application."
      ];
  List<String> problems = [
    "- Manques-tu de stratégie et de discipline ?",
    "- Paries-tu sur des émotions plutôt que sur des analyses ?",
    "- Gères-tu mal ton budget et tes mises ?",
    "- Suis-tu aveuglément les pronostics des autres ?",
    "- En as-tu marre de perdre tes paris ?"
  ];
  List<String> desires = [
    "- Gagner des grosses côtes et devenir riche grâce aux paris sportifs.",
    "- Aider financièrement ta famille et tes amis.",
    "- Payer tes frais de scolarité.",
    "- Avoir une vie de rêve grâce à tes gains.",
    "- Être financièrement libre et indépendant.",
    "- Avoir un moyen facile, très fiable pour te faire beaucoup d’argent rapidement.",
  ];
  List<String> capabilities = [
    "- Gagner facilement au moins 300.000f CFA par semaine.",
    "- Profiter d'un environnement simple, avec des fonctionnalités avancées pour faire de bonnes analyses.",
    "- Créer facilement des coupons fiables avec la cote qui te convient.",
    "- Bénéficier des conseils et méthodes pour bien gérer ton compte et tes mises.",
    "- Bien sélectionner les événements sur lesquels parier et ça peu importe le sport.",
    "- Faire des montantes en toute efficacité.",
    "- Prendre le contrôle de tes paris et maximiser tes gains."
  ];
  List<String> images = [
    'assets/appstore.png',
    'assets/features.png',
    'assets/allsport.png',
    'assets/team_working.png',
    'assets/update.png',
    'assets/money_emoji.png',
  ];
  List<String> textCarousselList = [
    "DanDo, Vous donne toutes les clés pour devenir un expert en paris et maximiser vos chances de gagner.",
    "Nous vous offrons un univers complet pour vous accompagner vers la réussite dans les paris sportifs.",
    "Parier sur tout les sports, Des fonctionnalités avancées pour faire de vous un parieur professionnel et rentable.",
    "Une équipe de développeurs expérimentés et d'analystes passionnés par les paris sportifs est à votre service.",
    "Nous vous assurons plus de contenus et de nouvelles fonctionnalités dans les mises à jour à venir.",
    "Commencez dès maintenant votre chemin vers le succès en obtenant un code d'accès ! Cliquer ici",
  ];
// Ne laissez plus le hasard dicter votre destin, prenez le contrôle de vos paris et transformez vos rêves en réalité
  List<Icon> contactIcons = [
    Icon(
      FontAwesomeIcons.whatsapp,
      color: Colors.teal.shade600,
    ),
    Icon(
      FontAwesomeIcons.telegram,
      color: Colors.blue.shade400,
    ),
    // const Icon(
    //   FontAwesomeIcons.instagram,
    //   color: Color(0xFFFF6F61),
    // ),
    // Icon(
    //   FontAwesomeIcons.facebook,
    //   color: Colors.blue.shade800,
    // ),
    // Icon(
    //   FontAwesomeIcons.youtube,
    //   color: Colors.red.shade700,
    // ),
    // const Icon(
    //   FontAwesomeIcons.tiktok,
    //   color: Colors.black,
    // )
  ];
  late RxString codeToPaste;
  late RxInt textCaroussel;
  late PrefsData _prefsData;
  final String price = "12 990f cfa",
      _phoneNumber = "2250173871065",
      _instagram = 'sapi1049';
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
    if (index == 2) {
      url = 'https://www.instagram.com/$_instagram';
    }
    if (index == 3) {
      url =
          "https://www.facebook.com/groups/1800469253785660/?ref=share&mibextid=NSMWBT";
    }
    if (index == 4) {
      url = "https://www.youtube.com/@BighID_RTaZed";
    }
    if (index == 5) {
      url = "https://www.tiktok.com/@byggy31";
    }
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
