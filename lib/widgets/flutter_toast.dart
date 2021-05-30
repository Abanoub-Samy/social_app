import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void successToast({
  required String message,
  Color backgroundColor = Colors.green,
  Color textColor = Colors.white,
  double fontSize = 16,
  Toast toastLength = Toast.LENGTH_LONG,
  ToastGravity gravity = ToastGravity.BOTTOM,
  int timeToShow = 3,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: toastLength,
    gravity: gravity,
    timeInSecForIosWeb: timeToShow,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: fontSize,
  );
}


void errorToast({
  required String message,
  Color backgroundColor = Colors.red,
  Color textColor = Colors.white,
  double fontSize = 16,
  Toast toastLength = Toast.LENGTH_LONG,
  ToastGravity gravity = ToastGravity.BOTTOM,
  int timeToShow = 3,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: toastLength,
    gravity: gravity,
    timeInSecForIosWeb: timeToShow,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: fontSize,
  );
}
