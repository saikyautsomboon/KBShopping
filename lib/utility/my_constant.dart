import 'package:flutter/material.dart';

class MyConstant {
  static String appName = 'KB Shopping';
  //route
  static String routeAuth = '/auth';
  static String routeRegister = '/register';
  static String routeByer = '/buyer';
  static String routeRider = '/rider';
  static String routeSaler = '/saler';

  //images
  static String image1 = 'images/1.png';
  static String image2 = 'images/2.png';
  static String image3 = 'images/3.png';
  static String image4 = 'images/4.png';
  static String image5 = 'images/5.png';

  //colors
  static Color primary = Color(0xfff48fb1);
  static Color dark = Color(0xffbf5f82);
  static Color light = Color(0xffffc1e3);

  //TextStyle
  TextStyle h1style() =>
      TextStyle(fontSize: 24, color: dark, fontWeight: FontWeight.bold);

  TextStyle h2style() =>
      TextStyle(fontSize: 18, color: dark, fontWeight: FontWeight.w700);

  TextStyle h3style() =>
      TextStyle(fontSize: 14, color: dark, fontWeight: FontWeight.normal);

  ButtonStyle mybuttonStyle() => ElevatedButton.styleFrom(
        primary: MyConstant.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );
}
