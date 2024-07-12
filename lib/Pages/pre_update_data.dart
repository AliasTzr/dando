import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:projet0_strat/Data/controller.dart';
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
  String _time = "", _date = "";
  DateTime? _dateTime;
  TimeOfDay? _timeOfDay;
  bool _canSendNotification = true, _notificationsEnabled = false;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

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
                  style: MyStyle(fontFamily: 'roboto', color: Controller.tealColor, fontWeight: FontWeight.w700, fontSize: 15),
                ),
                const SizedBox(height: 5,),
                formField(_newScoreTeamA, "Nouveau score (${widget.match.nameTeamA})", true, MediaQuery.of(context).size.width),
                const SizedBox(height: 5,),
                formField(_newScoreTeamB, "Nouveau score (${widget.match.nameTeamB})", true, MediaQuery.of(context).size.width),
                const SizedBox(height: 15,),
                const Text(
                  "Jour et heure du prochain match",
                  style: MyStyle(fontFamily: 'roboto', color: Controller.tealColor, fontWeight: FontWeight.w700, fontSize: 15),
                ),
                const SizedBox(height: 5,),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 4/10,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(Colors.teal),
                            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                          ),
                          onPressed: () async {
                            _dateTime = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(DateTime.now().day),
                              lastDate: DateTime(2100),
                            );
                            if (_dateTime != null) {
                              if (DateTime.now().isBefore(_dateTime!) || DateTime.now().year == _dateTime!.year && DateTime.now().month == _dateTime!.month && DateTime.now().day == _dateTime!.day) {
                                setState(() {
                                  _date = DateFormat('EEE d MMM yyyy', 'fr').format(_dateTime!);
                                });
                              } else {
                                setState(() {
                                  _dateTime = null;
                                  _date = "";
                                });
                                if(context.mounted) snackResult("Cette date est passée !", context, success: false, bottomPosition: false);
                              }
                            }
                          },
                          child: FittedBox(
                            child: Text(
                              _date.isEmpty ? "Jour" : _date,
                              style: const MyStyle(fontFamily: Controller.poppinsFamily, color: Controller.whiteColor, fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 2.2/10,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(Colors.teal),
                            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                          ),
                          onPressed: () async {
                            _canSendNotification = true;
                            _timeOfDay = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (_timeOfDay != null) {
                              if (_timeOfDay!.hour >= DateTime.now().hour) {
                                if (_timeOfDay!.hour == DateTime.now().hour && DateTime.now().minute >= _timeOfDay!.minute) {
                                  _canSendNotification = false;
                                  if(context.mounted) snackResult("Minute déjà écoulée !\nModifier afin de recevoir une notification.", context, success: false, bottomPosition: false);
                                }
                                setState(() {
                                  _time = formatTime(_timeOfDay!);
                                });
                              } else {
                                setState((){
                                  _timeOfDay = null;
                                  _time = "";
                                });
                                if(context.mounted) snackResult("Cette heure est déjà passée !", context, success: false, bottomPosition: false);
                              }
                            }
                          },
                          child: FittedBox(
                            child: Text(
                              _time.isEmpty ? "Heure" : _time,
                              style: const MyStyle(fontFamily: Controller.poppinsFamily, color: Controller.whiteColor, fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15,),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 3.8/5,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Controller.tealColor),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                    ),
                    onPressed: () async {
                      if (isNumeric(_newScoreTeamA.text) && isNumeric(_newScoreTeamB.text)) {
                        String newScoreA = insertNewScore(widget.match.scoresTeamA, int.parse(_newScoreTeamA.text).toString());
                        String newScoreB = insertNewScore(widget.match.scoresTeamB, int.parse(_newScoreTeamB.text).toString());
                        if(_date.isNotEmpty && _time.isNotEmpty){
                          await databaseHelper.updateMatch(Duel(id: widget.match.id, sport: widget.match.sport, championship: widget.match.championship, nameTeamA: widget.match.nameTeamA, scoresTeamA: newScoreA, nameTeamB: widget.match.nameTeamB, scoresTeamB: newScoreB, dataMatch: _date, timeMatch: _time));
                          if (_canSendNotification && _notificationsEnabled) {
                            DateTime dateTime = DateTime(_dateTime!.year, _dateTime!.month, _dateTime!.day, _timeOfDay!.hour, _timeOfDay!.minute);
                            await NotificationService.scheduleNotification(title: "${widget.match.nameTeamA} - ${widget.match.nameTeamB}", payload: widget.match.id.toString(), dateTime: dateTime);
                          } else {
                            if(context.mounted) snackResult("Vous ne serez pas notifié pour cet évènement !\nAutoriser les notifications ou changer l'heure puis réessayer !", context);
                          }
                          if(context.mounted) context.pop(true);
                        }
                      } else {
                        snackResult('type de score non pris en charge', context, success: false, );
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
