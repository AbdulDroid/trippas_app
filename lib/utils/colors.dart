import 'package:flutter/material.dart';

Color business = Color(0xff3E64FF);
Color vacation = Color(0xffFFC93E);
Color health = Color(0xffFF3E6C);
Color education = Color(0xff3EBAFF);
Color textLight = Color(0xffA5A2A2);
Color whiteShade = Color(0xdfFFFFFF);

MaterialColor createColor(Color c) {
  List strengths = <double>[.05];
  Map swatch = Map<int, Color>();

  final int r = c.red, g = c.green, b = c.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  strengths.forEach((s) {
    final double ds = 0.5 - s;
    swatch[(s * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(c.value, swatch);
}
