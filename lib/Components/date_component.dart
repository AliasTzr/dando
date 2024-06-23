import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projet0_strat/Components/my_text_style.dart';
import 'package:projet0_strat/Controllers/controller.dart';
import 'package:projet0_strat/Data/methodes.dart';

// ignore: must_be_immutable
class DateComponent extends StatefulWidget {
  DateTime? dateTime;
  TimeOfDay? timeOfDay;
  bool canSendNotification;
  String date = "", time = "";
  final dynamic getDateFunction, getTimeFunction;
  DateComponent({super.key, required this.dateTime, required this.timeOfDay, required this.canSendNotification, required this.date, required this.time, required this.getDateFunction, required this.getTimeFunction});

  @override
  State<DateComponent> createState() => _DateComponentState();
}

class _DateComponentState extends State<DateComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: Controller.width * 4/10,
            height: Controller.height * 0.06,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.teal),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ),
              onPressed: () async {
                widget.dateTime = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(DateTime.now().day),
                  lastDate: DateTime(2100),
                );
                if (widget.dateTime != null) {
                  if (DateTime.now().isBefore(widget.dateTime!) || DateTime.now().year == widget.dateTime!.year && DateTime.now().month == widget.dateTime!.month && DateTime.now().day == widget.dateTime!.day) {
                    setState(() {
                      widget.date = DateFormat('EEE d MMM yyyy', 'fr').format(widget.dateTime!);
                    });
                    widget.getDateFunction(widget.dateTime, widget.date);
                  } else {
                    setState(() {
                      widget.dateTime = null;
                      widget.date = "";
                    });
                    widget.getDateFunction(widget.dateTime, widget.date);
                    snackResult("Cette date est passée !", success: false, bottomPosition: false);
                  }
                }
              },
              child: FittedBox(
                child: Text(
                  widget.date.isEmpty ? "Jour" : widget.date,
                  style: const MyStyle(fontFamily: Controller.poppinsFamily, color: Controller.whiteColor, fontWeight: FontWeight.w600, fontSize: 15),
                ),
              ),
            ),
          ),
          SizedBox(width: Controller.width * 0.02,),
          SizedBox(
            width: Controller.width * 2.2/10,
            height: Controller.height * 0.06,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.teal),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
              ),
              onPressed: () async {
                widget.canSendNotification = true;
                widget.timeOfDay = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (widget.timeOfDay != null) {
                  if (widget.timeOfDay!.hour >= DateTime.now().hour) {
                    if (widget.timeOfDay!.hour == DateTime.now().hour && DateTime.now().minute >= widget.timeOfDay!.minute) {
                      widget.canSendNotification = false;
                      snackResult("Minute déjà écoulée !\nModifier afin de recevoir une notification.", success: false, bottomPosition: false);
                    }
                    setState(() {
                      widget.time = formatTime(widget.timeOfDay!);
                    });
                    widget.getTimeFunction(widget.timeOfDay, widget.time, widget.canSendNotification);
                  } else {
                    setState((){
                      widget.timeOfDay = null;
                      widget.time = "";
                    });
                    widget.getDateFunction(widget.dateTime, widget.date);
                    snackResult("Cette heure est déjà passée !", success: false, bottomPosition: false);
                  }
                }
              },
              child: FittedBox(
                child: Text(
                  widget.time.isEmpty ? "Heure" : widget.time,
                  style: const MyStyle(fontFamily: Controller.poppinsFamily, color: Controller.whiteColor, fontWeight: FontWeight.w600, fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}