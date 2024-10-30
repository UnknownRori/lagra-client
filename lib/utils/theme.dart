import 'package:flutter/material.dart';

class AppColor {
  static const bg = Color(0xFFFAFFFD);
  static const secondaryText = Color(0xFF323232);
  static const mainText = Color(0xFF010E0B);
  static const primary = Color(0xFF007A4B);
  static const secondary = Color(0xFF7CA2F3);
  static const accent = Color(0xFF480064);
  static const danger = Color(0xFFFF0000);
}

class Theme {
  final TextStyle title;
  final TextStyle subtitle;
  final TextStyle subtitle2;
  final TextStyle body1;
  final TextStyle body2;
  final TextStyle smallsub1;
  final TextStyle smallsub2;

  final EdgeInsets pagePadding;

  const Theme({
    required this.title,
    required this.subtitle,
    required this.subtitle2,
    required this.body1,
    required this.body2,
    required this.smallsub1,
    required this.smallsub2,
    required this.pagePadding,
  });
}

const Theme mobile = Theme(
  title: TextStyle(
      fontSize: 57, fontWeight: FontWeight.bold, fontFamily: 'poppins'),
  subtitle: TextStyle(
      fontSize: 36, fontWeight: FontWeight.bold, fontFamily: 'poppins'),
  subtitle2: TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'poppins'),
  body1: TextStyle(
      fontSize: 16, fontFamily: 'poppins', fontWeight: FontWeight.bold),
  body2: TextStyle(fontSize: 16, fontFamily: 'poppins'),
  smallsub1: TextStyle(
      fontSize: 12, fontFamily: 'poppins', fontWeight: FontWeight.bold),
  smallsub2: TextStyle(fontSize: 12, fontFamily: 'poppins'),
  pagePadding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 24),
);
