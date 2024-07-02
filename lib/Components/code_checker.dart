import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/Data/controller.dart';
import 'package:projet0_strat/Data/login_data.dart';
import 'package:projet0_strat/Data/methodes.dart';
import 'package:projet0_strat/Data/route_named.dart';
import 'package:projet0_strat/Models/prefs_data.dart';
import 'package:projet0_strat/api/api.dart';

class CodeChecker extends StatefulWidget {
  const CodeChecker({super.key});

  @override
  State<CodeChecker> createState() => _CodeCheckerState();
}

class _CodeCheckerState extends State<CodeChecker> {
  late String _codeToPaste, _stateLoader;
  late PrefsData _prefsData;
  @override
  void initState() {
    super.initState();
    _codeToPaste= "Cliquer ici pour coller le code";
    _stateLoader = "empty";
    _prefsData = PrefsData();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 10,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          color: Colors.transparent,
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 9),
          child: _stateLoader.contains("empty") ? RichText(
              text: TextSpan(
                style: const MyStyle(fontFamily: "acme", color: Controller.blackColor, fontWeight: FontWeight.w500, fontSize: 15),
                children: [
                  const TextSpan(
                    text: "Profitez-en vite !\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  const TextSpan(
                    text: "Le code d'accès actuellement à ",
                  ),
                  const TextSpan(
                    text: "${LoginData.price}  !\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  TextSpan(
                    text: "Nombre de place limitée !",
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontWeight: FontWeight.w700
                    )
                  )
                ]
              ),
            ) : _stateLoader.contains("loading") ? const SpinKitPouringHourGlassRefined(
              color: Controller.tealColor,
            ) : Text(
              _stateLoader, 
              style: MyStyle(fontFamily: "acme", color: Colors.red.shade700, fontWeight: FontWeight.bold, fontSize: 18),
            )
        ),
        InkWell(
          onTap: () async {
            String code = await FlutterClipboard.paste();
            if (code.isNotEmpty && code.trim().isNotEmpty) {
              setState(() {
                _codeToPaste = code.replaceAll(" ", "");
              });
            } else {
              setState(() {
                _codeToPaste = "Cliquer ici pour coller le code";
              });
              if(context.mounted) snackResult("Aucun code recu", context);
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width, 
            height: MediaQuery.of(context).size.height / 13,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Controller.tealColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Controller.tealColor, width: 3)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: const EdgeInsets.all(10),
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Controller.bgColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      _codeToPaste.contains("TZ") ? _codeToPaste.toUpperCase() : _codeToPaste,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                      style: const MyStyle(
                        fontFamily: 'acme',
                        color: Controller.blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 19.5
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: Icon(MdiIcons.contentPaste)
                )
              ],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: (){
            if (_codeToPaste.length == 24 && _codeToPaste.contains("TZ")) {
              _accesProvider(context);
            } else {
              snackResult("Code incorrecte", context, success: false);
            }
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Controller.tealColor),
            shape: WidgetStateProperty.all(const StadiumBorder()),
          ),
          child: const Text(
            "Vérifier",
            style: MyStyle(
              fontFamily: 'acme',
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 15
            ),
          ),
        ),
      ],
    );
  }
  Future<void> _accesProvider(BuildContext context) async {
    setState(() {
      _stateLoader = "loading";
    });
    try {
      Api().useCode(_codeToPaste).then((response) async {
        await _prefsData.setBoolData("isLogged", true);
        if(context.mounted) snackResult(response, context);
        if (context.mounted) context.goNamed(RoutesNamed.home);
      }, onError: (error) async {
        setState(() {
          _stateLoader = error.toString();
        });
        await Future.delayed(const Duration(seconds: 10));
        setState(() {
          _stateLoader = "empty";
        });
      });
    } catch (e) {
      setState(() {
        _stateLoader = "empty";
      });
      snackResult("Vérifier votre connexion internet.", context, success: false,);
      
    }
  }
}