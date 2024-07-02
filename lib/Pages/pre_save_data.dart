import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:projet0_strat/Components/date_component.dart';
import 'package:projet0_strat/Components/dropdown_child.dart';
import 'package:projet0_strat/Data/controller.dart';
import 'package:projet0_strat/Data/db_sql_project.dart';
import 'package:projet0_strat/Data/methodes.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/Models/matches_model.dart';
import 'package:projet0_strat/features/noti_service.dart';

class PreSaveData extends StatefulWidget {
  final String scoresTeamA, scoresTeamB;
  const PreSaveData({super.key, required this.scoresTeamA, required this.scoresTeamB});

  @override
  State<PreSaveData> createState() => _PreSaveDataState();
}

class _PreSaveDataState extends State<PreSaveData> {
  String dropdownValue = "Type de sport", _date = "", _time = "";
  DateTime? _dateTime;
  TimeOfDay? _timeOfDay;
  bool _canSendNotification = true, _notificationsEnabled = false;
  DatabaseHelper databaseHelper = DatabaseHelper();
  final TextEditingController _championship = TextEditingController();
  final TextEditingController _nameTeamA = TextEditingController();
  final TextEditingController _nameTeamB = TextEditingController();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void refreshDate(DateTime? getDateTime, String getDate) {
    setState(() {
      _dateTime = getDateTime;
      _date = getDate;
    });
  }

  void refreshTime(TimeOfDay? getTimeOfDay,  String getTime, bool getCanSendNotification) {
    setState(() {
      _timeOfDay = getTimeOfDay;
      _time = getTime;
      _canSendNotification = getCanSendNotification;
    });
  }

  @override
  void initState() {
    _checkNotificationPermissions();
    _requestPermissions();
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
  void dispose() {
    databaseHelper.closeDatabase();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/20),
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
                        context.pop();
                      },
                      splashRadius: 20,
                      icon: const Icon(Icons.cancel, color: Colors.grey,)
                  ),
                ),
                const Text(
                    "Remplissez le formulaire",
                    style: MyStyle(fontFamily: Controller.oswaldFamily, color: Controller.tealColor, fontWeight: FontWeight.normal, fontSize: 17),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 3/5,
                  child: DropdownButton(
                    value: dropdownValue,
                    isExpanded: true,
                    menuMaxHeight: MediaQuery.of(context).size.height / 3.5,
                    underline: Container(color: Controller.tealColor, height: 2,),
                    onChanged: (String? newValue){
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: "Type de sport",
                          child: DropdownChild(text: "Type de sport", icon: "Type de sport")
                      ),
                      DropdownMenuItem(
                          value: "basketball",
                          child: DropdownChild(text: "Basketball", icon: "basketball")
                      ),
                      DropdownMenuItem(
                          value: "soccer",
                          child: DropdownChild(text: "Football", icon: "soccer")
                      ),
                      DropdownMenuItem(
                          value: "tennisBallOutline",
                          child: DropdownChild(text: "Tennis", icon: "tennisBallOutline")
                      ),
                      DropdownMenuItem(
                          value: "hockeySticks",
                          child: DropdownChild(text: "Hockey", icon: "hockeySticks")
                      ),
                      DropdownMenuItem(
                          value: "baseballBat",
                          child: DropdownChild(text: "Baseball", icon: "baseballBat")
                      ),
                      DropdownMenuItem(
                          value: "football",
                          child: DropdownChild(text: "Rugby", icon: "football")
                      ),
                      DropdownMenuItem(
                          value: "cricket",
                          child: DropdownChild(text: "Cricket", icon: "cricket")
                      ),
                      DropdownMenuItem(
                          value: "handball",
                          child: DropdownChild(text: "Handball", icon: "handball"),
                      ),
                      DropdownMenuItem(
                          value: "volleyball",
                          child: DropdownChild(text: "Volleyball", icon: 'volleyball',)
                      ),
                    ],
                  ),
                ),
                formField(_championship, "Nom du championnat", false, MediaQuery.of(context).size.width),
                const SizedBox(height: 5,),
                formField(_nameTeamA, "Nom de l'équipe A", false, MediaQuery.of(context).size.width),
                const SizedBox(height: 5,),
                formField(_nameTeamB, "Nom de l'équipe B", false, MediaQuery.of(context).size.width),
                const SizedBox(height: 5,),
                DateComponent(dateTime: _dateTime, timeOfDay: _timeOfDay, canSendNotification: _canSendNotification, date: _date, time: _time, getDateFunction: refreshDate, getTimeFunction: refreshTime,),
                const SizedBox(height: 15,),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 3.8/5,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.teal),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                    ),
                    onPressed: () async {
                      if (_dateTime != null && _timeOfDay != null) {
                        int id = 0;
                        if(_championship.text.isNotEmpty && _nameTeamA.text.isNotEmpty && _nameTeamB.text.isNotEmpty && _date.isNotEmpty && _time.isNotEmpty){
                          id = await databaseHelper.insertMatch(Duel(sport: dropdownValue, championship: _championship.text, nameTeamA: _nameTeamA.text, scoresTeamA: widget.scoresTeamA, nameTeamB: _nameTeamB.text, scoresTeamB: widget.scoresTeamB, dataMatch: _date, timeMatch: _time));
                          if (_canSendNotification && _notificationsEnabled) {
                            DateTime dateTime = DateTime(_dateTime!.year, _dateTime!.month, _dateTime!.day, _timeOfDay!.hour, _timeOfDay!.minute);
                            await NotificationService.scheduleNotification(title: "${_nameTeamA.text} - ${_nameTeamB.text}", payload: id.toString(), dateTime: dateTime);
                          } else {
                            if(context.mounted) snackResult("Vous ne serez pas notifié pour cet évènement !\nAutoriser les notifications ou changer l'heure puis réessayer !",context);
                          }
                          if(context.mounted) context.pop(true);
                        } else {
                          snackResult("Tous les champs sont réquis !", context, success: false);
                        }
                      } else {
                        snackResult("La date et l'heure sont réquisent !", context, success: false);
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
