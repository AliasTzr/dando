import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:projet0_strat/Components/date_component.dart';
import 'package:projet0_strat/Controllers/controller.dart';
import 'package:projet0_strat/Models/matches_model.dart';
import 'package:projet0_strat/Data/db_sql_project.dart';
import 'package:projet0_strat/Data/methodes.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/features/noti_service.dart';

class PreUpdateData extends StatefulWidget {
  final Duel match;
  const PreUpdateData({super.key, required this.match});
  @override
  State<PreUpdateData> createState() => _PreUpdateDataState();
}

class _PreUpdateDataState extends State<PreUpdateData> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  final TextEditingController _newScoreTeamA = TextEditingController();
  final TextEditingController _newScoreTeamB = TextEditingController();
  String _newTime = "", _newDate = "";
  DateTime? _dateTime;
  TimeOfDay? _timeOfDay;
  bool _canSendNotification = true, _notificationsEnabled = false;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void refreshDate(DateTime? getDateTime, String getDate) {
    setState(() {
      _dateTime = getDateTime;
      _newDate = getDate;
    });
  }

  void refreshTime(TimeOfDay? getTimeOfDay,  String getTime, bool getCanSendNotification) {
    setState(() {
      _timeOfDay = getTimeOfDay;
      _newTime = getTime;
      _canSendNotification = getCanSendNotification;
    });
  }

  @override
  void initState() {
    _requestPermissions();
    _checkNotificationPermissions();
    super.initState();
  }

  Future<void> _checkNotificationPermissions() async {
    if (Platform.isAndroid || Platform.isIOS) {
      bool granted = false;
      if (Platform.isAndroid) {
        final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
            flutterLocalNotificationsPlugin
                .resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>();
        granted = await androidImplementation?.areNotificationsEnabled() ?? false;
      } else if (Platform.isIOS) {
        final IOSFlutterLocalNotificationsPlugin? iosImplementation =
            flutterLocalNotificationsPlugin
                .resolvePlatformSpecificImplementation<
                    IOSFlutterLocalNotificationsPlugin>();
        granted = await iosImplementation?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            ) ??
            false;
      }

      setState(() {
        _notificationsEnabled = granted;
      });
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? grantedNotificationPermission =
          await androidImplementation?.requestNotificationsPermission();
      setState(() {
        _notificationsEnabled = grantedNotificationPermission ?? false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: Controller.width/20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: (){
                      Get.back();
                    },
                    splashRadius: 20,
                    icon: const Icon(Icons.cancel, color: Colors.grey,)
                  ),
                ),
                const Text(
                  "Remplissez le formulaire",
                  style: MyStyle(fontFamily: 'roboto', color: Controller.tealColor, fontWeight: FontWeight.w700, fontSize: 15),
                ),
                const SizedBox(height: 5,),
                formField(_newScoreTeamA, "Nouveau score (${widget.match.nameTeamA})", true),
                const SizedBox(height: 5,),
                formField(_newScoreTeamB, "Nouveau score (${widget.match.nameTeamB})", true),
                const SizedBox(height: 15,),
                const Text(
                  "Jour et heure du prochain match",
                  style: MyStyle(fontFamily: 'roboto', color: Controller.tealColor, fontWeight: FontWeight.w700, fontSize: 15),
                ),
                const SizedBox(height: 5,),
                DateComponent(dateTime: _dateTime, timeOfDay: _timeOfDay, canSendNotification: _canSendNotification, date: _newDate, time: _newTime, getDateFunction: refreshDate, getTimeFunction: refreshTime),
                const SizedBox(height: 15,),
                SizedBox(
                  width: Controller.width * 3.8/5,
                  height: Controller.height * 0.06,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Controller.tealColor),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                    ),
                    onPressed: () async {
                      if (_newScoreTeamA.text.isNumericOnly && _newScoreTeamB.text.isNumericOnly) {
                        String newScoreA = insertNewScore(widget.match.scoresTeamA, int.parse(_newScoreTeamA.text).toString());
                        String newScoreB = insertNewScore(widget.match.scoresTeamB, int.parse(_newScoreTeamB.text).toString());
                        if(_newDate.isNotEmpty && _newTime.isNotEmpty){
                          await databaseHelper.updateMatch(Duel(id: widget.match.id, sport: widget.match.sport, championship: widget.match.championship, nameTeamA: widget.match.nameTeamA, scoresTeamA: newScoreA, nameTeamB: widget.match.nameTeamB, scoresTeamB: newScoreB, dataMatch: _newDate, timeMatch: _newTime));
                          if (_canSendNotification && _notificationsEnabled) {
                            DateTime dateTime = DateTime(_dateTime!.year, _dateTime!.month, _dateTime!.day, _timeOfDay!.hour, _timeOfDay!.minute);
                            await NotificationService.scheduleNotification(title: "${widget.match.nameTeamA} - ${widget.match.nameTeamB}", payload: widget.match.id.toString(), dateTime: dateTime);
                          } else {
                            snackResult("Vous ne serez pas notifié pour cet évènement !\nAutoriser les notifications ou changer l'heure puis réessayer !");
                          }
                          Get.back(result: true);
                        }
                      } else {
                        snackResult('type de score non pris en charge', success: false, );
                      }
                    },
                    child: const Text(
                      "Sauvegarder",
                      style: MyStyle(fontFamily: Controller.oswaldFamily, color: Controller.whiteColor, fontWeight: FontWeight.w600, fontSize: 16, letterSpacing: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
