import 'package:flutter/material.dart';

class MyConstant {
  static String appName = 'KB Shopping';
  //domain
  static String domain = 'https://4ef4-185-205-143-50.ngrok.io';
  //route
  static String routeAuth = '/auth';
  static String routeRegister = '/register';
  static String routeByer = '/buyer';
  static String routeRider = '/rider';
  static String routeSaler = '/saler';
  static String routeAddProduct = '/addproduct';

  //images
  static String image1 = 'images/1.png';
  static String image2 = 'images/2.png';
  static String image3 = 'images/3.png';
  static String image4 = 'images/4.png';
  static String image5 = 'images/5.png';
  static String image6 = 'images/6.png';
  static String avatar = 'images/avatar.png';

  //colorss
  static Color primary = Color(0xfff48fb1);
  static Color dark = Color(0xffbf5f82);
  static Color light = Color(0xffffc1e3);

  static Map<int, Color> mapMaterialColor = {
    50: Color.fromRGBO(244, 143, 177, 0.1),
    100: Color.fromRGBO(244, 143, 177, 0.2),
    200: Color.fromRGBO(244, 143, 177, 0.3),
    300: Color.fromRGBO(244, 143, 177, 0.4),
    400: Color.fromRGBO(244, 143, 177, 0.5),
    500: Color.fromRGBO(244, 143, 177, 0.6),
    600: Color.fromRGBO(244, 143, 177, 0.7),
    700: Color.fromRGBO(244, 143, 177, 0.8),
    800: Color.fromRGBO(244, 143, 177, 0.9),
    900: Color.fromRGBO(244, 143, 177, 1.0),
  };

  //TextStyle
  TextStyle h1style() =>
      TextStyle(fontSize: 24, color: dark, fontWeight: FontWeight.bold);

  TextStyle h2style() =>
      TextStyle(fontSize: 18, color: dark, fontWeight: FontWeight.w700);

  TextStyle h2Whitestyle() =>
      TextStyle(fontSize: 18, color: light, fontWeight: FontWeight.w700);

  TextStyle h3style() =>
      TextStyle(fontSize: 14, color: dark, fontWeight: FontWeight.normal);

  TextStyle h3Whitestyle() =>
      TextStyle(fontSize: 14, color: light, fontWeight: FontWeight.normal);

  ButtonStyle mybuttonStyle() => ElevatedButton.styleFrom(
        primary: MyConstant.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );
}
