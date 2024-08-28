// ignore_for_file: camel_case_extensions

import 'package:flutter/material.dart';

extension colors on ColorScheme {
  static MaterialColor primaryApp = const MaterialColor(
    0xffE7191F,
    <int, Color>{
      50: primary,
      100: primary,
      200: primary,
      300: primary,
      400: primary,
      500: primary,
      600: primary,
      700: primary,
      800: primary,
      900: primary,
    },
  );

  // static const Color primary = Color(0xff305F61);
  // static const Color secondary = Color(0xffFF5C59);
  static const Color primary = Color(0xff305F61);
  static const Color secondary = Color(0xffee3623);
  static const Color bgColor = Colors.white;
  static const Color cardBg = Color(0xffF7F7F7);
  static const Color bottomNav = Color(0xffFBB95B);
  static const Color textMain = Color(0xff305F61);
  static const Color themeButton = Color(0xff305F61);
  static const Color spText = Color(0xffFF5C59);

  static const Color third = Color(0xffE4F8FF);

  static const Color fontColor = Color(0xff000000);
  static const Color hintText = Color(0xff9d9d9d);
  static const Color borderColor = Color(0x29000000);

  static const Color white = Colors.white;
  static const Color lightWhite = Color(0xffEFEFEF);
  static const Color lightWhite2 = Color(0xffF5F5F5);
  static const Color lightGrey = Color(0xff939393);
  static const Color grey = Color(0xff8A8A8A);

  static const Color red = Color(0xffFD8D8D);
  static const Color green = Color(0xff189a2b);
  static const Color orange = Color(0xffffb984);
  static const Color black = Color(0xff000000);
  static const Color lightBlack = Color(0xff52575c);
}
