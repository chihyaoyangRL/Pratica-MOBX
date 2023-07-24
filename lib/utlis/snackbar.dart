import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Snackbar {
  static String title = 'Aviso';
  static String message = 'A solicitação atingiu o tempo limite';
  static SnackPosition snackPosition = SnackPosition.TOP;
  static Color backgroundColor = Colors.indigoAccent;
  static Duration duration = Duration(seconds: 10);
  static EdgeInsets margin = EdgeInsets.only(right: 20, left: 20);
  static Widget icon = Icon(Icons.signal_wifi_off, color: Colors.white);
  static double borderRadius = 30;
  static BorderRadiusGeometry borderRadiusG = BorderRadius.circular(5.0);
  static double minWidth = 35;
  static double height = 35;
  static Color colorButton = Colors.greenAccent;
  static Widget iconButton = Icon(FontAwesomeIcons.redoAlt, color: Colors.white, size: 18);
}
