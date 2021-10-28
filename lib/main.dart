import 'dart:js';

import 'package:flutter/material.dart';
import 'package:kbshopping/state/%20register_service.dart';
import 'package:kbshopping/state/auth.dart';
import 'package:kbshopping/state/buyer_service.dart';
import 'package:kbshopping/state/rider_service.dart';
import 'package:kbshopping/state/saler_service.dart';
import 'package:kbshopping/utility/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  '/auth': (BuildContext context) => Auth(),
  '/register': (BuildContext context) => Register(),
  '/buyer': (BuildContext context) => Buyer(),
  '/rider': (BuildContext context) => Rider(),
  '/saler': (BuildContext context) => Saler(),
};

String initialRoute;
void main() {
  initialRoute = MyConstant.routeAuth;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
// const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: initialRoute,
    );
  }
}
