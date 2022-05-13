
import 'package:flutter/material.dart';

ThemeData yellowCabTheme(){
  final ThemeData base = ThemeData.light();

  return base.copyWith(
//    primarySwatch: Colors.amber,
    brightness: Brightness.light,
    primaryColor: Color(0xffffc107),
    primaryColorBrightness: Brightness.light,
    primaryColorLight: Color(0xffffecb3),
    primaryColorDark: Color(0xffffa000),
    accentColor: Color(0xffffc107),
    accentColorBrightness: Brightness.light,
    canvasColor: Color(0xfffafafa),
    scaffoldBackgroundColor: Color(0xfffafafa),
    bottomAppBarColor: Color(0xffffffff),
    cardColor: Color(0xffffffff),
    dividerColor: Color(0x1f000000),
    highlightColor: Color(0x66bcbcbc),
    splashColor: Color(0x66c8c8c8),
    selectedRowColor: Color(0xfff5f5f5),
    unselectedWidgetColor: Color(0x8a000000),
    disabledColor: Color(0x61000000),
    buttonColor: Color(0xffe0e0e0),
    toggleableActiveColor: Color(0xffffb300),
    secondaryHeaderColor: Color(0xfffff8e1),
    textSelectionColor: Color(0xffffe082),
    cursorColor: Color(0xff4285f4),
    textSelectionHandleColor: Color(0xffffd54f),
    backgroundColor: Color(0xffffe082),
    dialogBackgroundColor: Color(0xffffffff),
    indicatorColor: Color(0xffffc107),
    hintColor: Color(0x8a000000),
    errorColor: Color(0xffd32f2f),

    iconTheme: IconThemeData(
      color: Color(0xdd000000),
      opacity: 1.0,
      size: 24.0,
    ),


  );
}

