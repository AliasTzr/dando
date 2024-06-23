import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:projet0_strat/Data/route_named.dart';
import 'package:projet0_strat/Models/matches_model.dart';
import 'package:projet0_strat/Pages/about_app.dart';
import 'package:projet0_strat/Pages/login.dart';
import 'package:projet0_strat/Pages/screen_manager.dart';
import 'package:projet0_strat/Pages/show_match.dart';
import 'package:projet0_strat/features/noti_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initNotificationService();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GoRouter _router = GoRouter(
    redirect: (context, state) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('isLogged') ?? false) {
        return "/home";
      } else {
        return "/";
      }
    },
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
            name: RoutesNamed.matchDetails,
            path: RoutesNamed.matchDetails,
            builder: (context, state) => MatchDetails(match: state.extra as Duel),
          )
        ]
      ),
    ]
  );
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
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}