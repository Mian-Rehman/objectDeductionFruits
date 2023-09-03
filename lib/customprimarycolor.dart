 import 'package:flutter/material.dart';

const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFE1E1FC),
  100: Color(0xFFB5B3F7),
  200: Color(0xFF8480F1),
  300: Color(0xFF524DEB),
  400: Color(0xFF2D27E7),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFF0701E0),
  700: Color(0xFF0601DC),
  800: Color(0xFF0401D8),
  900: Color(0xFF0200D0),
});
 const int _primaryPrimaryValue = 0xFF0801E3;

 const MaterialColor primaryAccent = MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFFF8F8FF),
  200: Color(_primaryAccentValue),
  400: Color(0xFF9292FF),
  700: Color(0xFF7979FF),
});
 const int _primaryAccentValue = 0xFFC5C5FF;