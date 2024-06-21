import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:projet0_strat/Pages/about_app.dart';
import 'package:projet0_strat/Pages/screen_manager.dart';
import 'package:projet0_strat/features/noti_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projet0_strat/Components/waiting_component.dart';
import 'package:projet0_strat/Pages/login.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initNotificationService();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
      home: FutureBuilder<bool>(
        future: isLoggedIn(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const WaitingComponent(isInitApp: true,);
          } else {
            return snapshot.data! ? const  ScreenManager() : const LoginScreen();
          }
        }
      ),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/home',
          page: () => const ScreenManager(),
        ),
        GetPage(
          name: '/aboutapp',
          page: () => AboutApp(),
        )
      ],
    );
  }
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FlutterNativeSplash.remove();
    return prefs.getBool('isLogged') ?? false;
  }
}