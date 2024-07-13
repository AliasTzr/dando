import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:projet0_strat/Controllers/my_extra_codec.dart';
import 'package:projet0_strat/Data/route_named.dart';
import 'package:projet0_strat/Models/matches_model.dart';
import 'package:projet0_strat/Pages/about_app.dart';
import 'package:projet0_strat/Pages/data_saved.dart';
import 'package:projet0_strat/Pages/login.dart';
import 'package:projet0_strat/Pages/screen_manager.dart';
import 'package:projet0_strat/Pages/show_match.dart';
import 'package:projet0_strat/features/noti_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initNotificationService();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs,));
}
class MyApp extends StatelessWidget {
  final SharedPreferences? prefs;
  const MyApp({super.key, required this.prefs});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('fr', '')
      ],
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      routerConfig: GoRouter(
        extraCodec: const MyDuelCodec(),
        initialLocation: prefs!.getBool('isLogged') ?? false ? "/home" : "/",
        routes: [
          GoRoute(
            name: RoutesNamed.login,
            path: "/",
            builder: (context, state) => const LoginScreen(),
            routes: [
              GoRoute(
                name: RoutesNamed.aboutapp,
                path: RoutesNamed.aboutapp,
                builder: (context, state) => const AboutApp(),
              )
            ]
          ),
          GoRoute(
            name: RoutesNamed.home,
            path: "/${RoutesNamed.home}",
            builder: (context, state) => const ScreenManager(),
            routes: [
              GoRoute(
                name: RoutesNamed.storage,
                path: RoutesNamed.storage,
                builder: (context, state) => const Storage(),
                routes: [
                  GoRoute(
                    name: RoutesNamed.matchDetails,
                    path: RoutesNamed.matchDetails,
                    builder: (context, state) => MatchDetails(match: state.extra as Duel),
                  ),
                ]
              )
            ]
          ),
        ]
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}