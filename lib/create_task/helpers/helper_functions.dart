import 'package:flutter/material.dart';

String getTimeText(TimeOfDay timeOfDay) {
  String text;

  String hours = timeOfDay.hourOfPeriod.toString();
  String minutes = timeOfDay.minute.toString();
  String amOrPm = timeOfDay.period.name.toUpperCase();

  if (minutes.length == 1) {
    minutes = '0$minutes';
  }
  text = '$hours:$minutes $amOrPm';

  return text;
}
