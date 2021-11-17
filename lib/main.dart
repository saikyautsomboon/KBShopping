import 'package:flutter/material.dart';
import 'package:kbshopping/state/register_service.dart';
import 'package:kbshopping/state/auth.dart';
import 'package:kbshopping/state/buyer_service.dart';
import 'package:kbshopping/state/rider_service.dart';
import 'package:kbshopping/state/saler_service.dart';
import 'package:kbshopping/utility/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, WidgetBuilder> map = {
  '/auth': (BuildContext context) => Auth(),
  '/register': (BuildContext context) => Register(),
  '/buyer': (BuildContext context) => Buyer(),
  '/rider': (BuildContext context) => Rider(),
  '/saler': (BuildContext context) => Saler(),
};

String initialRoute;
Future<Null> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // main Future ကို ပြီးအောင်လုပ်ပြီးမှအောက်ကိုဆက်သွားမယ်
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String usertype = preferences.getString('usertype'); //getString('key')
  if (usertype?.isEmpty ?? true) {
    print('## UserType ==>> $usertype');
    initialRoute = MyConstant.routeAuth;
    runApp(MyApp());
  } else {
    switch (usertype) {
      case 'Buyer':
        initialRoute = MyConstant.routeByer;
        runApp(MyApp());
        break;
      case 'Seller':
        initialRoute = MyConstant.routeSaler;
        runApp(MyApp());
        break;
      case 'Driver':
        initialRoute = MyConstant.routeRider;
        runApp(MyApp());
        break;
      default:
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: MyConstant.appName,
      routes: map,
      initialRoute: initialRoute,
    );
  }
}
